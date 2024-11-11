from flask import Flask, render_template, request, redirect, url_for, flash, session
import pymysql
import bcrypt
import os
from werkzeug.utils import secure_filename

# Membuat aplikasi Flask
app = Flask(__name__)
app.secret_key = 'rahasiadong'  # Kunci untuk session dan flash messages

# Konfigurasi database
db_config = {
    'host': 'localhost',
    'user': 'root',         # Ganti dengan username MySQL Anda
    'password': '',         # Ganti dengan password MySQL Anda jika ada
    'database': 'simpas',   # Nama database Anda
}

# Konfigurasi folder untuk upload gambar
app.config['UPLOAD_FOLDER'] = 'static/uploads'
app.config['ALLOWED_EXTENSIONS'] = {'png', 'jpg', 'jpeg', 'gif'}

# Fungsi untuk memeriksa ekstensi file gambar yang di-upload
def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in app.config['ALLOWED_EXTENSIONS']

# Halaman utama (landing page)
@app.route("/")
def hello_world():
    return render_template("landing.html")

# Halaman chatbot
@app.route("/chatbot")
def chatbot():
    return render_template("chatbot.html")

# Halaman artikel
@app.route("/artikel")
def artikel():
    # Ambil data artikel dari database
    connection = pymysql.connect(**db_config)
    cur = connection.cursor()
    cur.execute("SELECT id, title, content, image_filename FROM articles")  # Menambahkan id ke query
    articles = cur.fetchall()
    cur.close()
    connection.close()
    return render_template("artikel.html", articles=articles)

@app.route("/artikel/<int:id>")
def article_detail(id):
    # Ambil artikel berdasarkan id dari database
    connection = pymysql.connect(**db_config)
    cur = connection.cursor()
    cur.execute("SELECT title, content, image_filename FROM articles WHERE id = %s", (id,))
    article = cur.fetchone()
    cur.close()
    connection.close()
    return render_template("artikel_detail.html", article=article)

# Menampilkan daftar artikel
@app.route('/articles')
def articles():
    if 'user_id' not in session:
        return redirect(url_for('login_admin'))  # Jika belum login, arahkan ke halaman login
    connection = pymysql.connect(**db_config)
    cur = connection.cursor()
    cur.execute("SELECT * FROM articles")
    articles = cur.fetchall()
    cur.close()
    connection.close()
    return render_template('admin/articles.html', articles=articles)

# Menambahkan artikel baru
@app.route('/add_article', methods=['GET', 'POST'])
def add_article():
    if 'user_id' not in session:
        return redirect(url_for('login_admin'))  # Jika belum login, arahkan ke halaman login

    if request.method == 'POST':
        title = request.form['title']
        content = request.form['content']
        image = request.files['image']

        # Mengecek apakah file gambar di-upload dan memiliki ekstensi yang valid
        if image and allowed_file(image.filename):
            filename = secure_filename(image.filename)
            image.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))

            # Menyimpan artikel ke database
            connection = pymysql.connect(**db_config)
            cur = connection.cursor()
            cur.execute("INSERT INTO articles (title, content, image_filename) VALUES (%s, %s, %s)",
                        (title, content, filename))
            connection.commit()
            cur.close()
            connection.close()
            flash("Article added successfully!")
            return redirect(url_for('articles'))
    return render_template('admin/add_article.html')

# Mengedit artikel
@app.route('/edit_article/<int:id>', methods=['GET', 'POST'])
def edit_article(id):
    if 'user_id' not in session:
        return redirect(url_for('login_admin'))  # Jika belum login, arahkan ke halaman login

    connection = pymysql.connect(**db_config)
    cur = connection.cursor()
    cur.execute("SELECT * FROM articles WHERE id = %s", (id,))
    article = cur.fetchone()

    if request.method == 'POST':
        title = request.form['title']
        content = request.form['content']
        image = request.files['image']
        
        if image and allowed_file(image.filename):
            filename = secure_filename(image.filename)
            image.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
        else:
            filename = article[3]  # Jika gambar tidak diubah, gunakan gambar lama

        # Memperbarui artikel di database
        cur.execute("UPDATE articles SET title = %s, content = %s, image_filename = %s WHERE id = %s",
                    (title, content, filename, id))
        connection.commit()
        cur.close()
        connection.close()
        flash("Article updated successfully!")
        return redirect(url_for('articles'))

    connection.close()
    return render_template('admin/edit_article.html', article=article)

# Menghapus artikel
@app.route('/delete_article/<int:id>')
def delete_article(id):
    if 'user_id' not in session:
        return redirect(url_for('login_admin'))  # Jika belum login, arahkan ke halaman login

    connection = pymysql.connect(**db_config)
    cur = connection.cursor()
    cur.execute("DELETE FROM articles WHERE id = %s", (id,))
    connection.commit()
    cur.close()
    connection.close()
    flash("Article deleted successfully!")
    return redirect(url_for('articles'))

#loginadmin
@app.route('/admin/login', methods=['GET', 'POST'])
def login_admin():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']
        
        # Koneksi ke database untuk mengecek data login
        connection = pymysql.connect(**db_config)
        cur = connection.cursor()
        
        # Query untuk mengambil data admin berdasarkan email
        cur.execute("SELECT * FROM admin WHERE email = %s", (email,))
        user = cur.fetchone()  # Ambil satu record
        
        if user:
            stored_hash = user[2]  # Ambil password yang telah di-hash dari database
            
            # Verifikasi password yang dimasukkan dengan password yang tersimpan di database
            if bcrypt.checkpw(password.encode('utf-8'), stored_hash.encode('utf-8')):
                session['user_id'] = user[0]  # Simpan ID user di session
                flash("Login successful!", "success")
                return redirect(url_for('admin_dashboard'))  # Redirect ke dashboard admin
            else:
                flash("Invalid password", "danger")
        else:
            flash("Email not found", "danger")
        
        cur.close()
        connection.close()
    
    return render_template('admin/login_admin.html')  # Tampilkan halaman login

@app.route('/admin_dashboard')
def admin_dashboard():
    # Pastikan hanya admin yang login yang dapat mengakses dashboard
    if 'user_id' not in session:
        return redirect(url_for('login_admin'))  # Jika belum login, arahkan ke halaman login
    
    return render_template('admin/admin_dashboard.html')  # Dashboard admin

@app.route('/logout')
def logout():
    session.pop('user_id', None)  # Hapus data user_id dari session
    flash("You have been logged out.", "info")
    return redirect(url_for('login_admin'))  # Redirect ke halaman login


if __name__ == '__main__':
    app.run(debug=True)
