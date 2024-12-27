from flask import Flask, render_template, request, redirect, url_for, flash, session
import pymysql
import bcrypt
import os
from werkzeug.utils import secure_filename

# Membuat aplikasi Flask
app = Flask(__name__)
app.secret_key = 'rahasiadong' 

# Konfigurasi database
db_config = {
    'host': 'localhost',
    'user': 'root',         
    'password': '',         
    'database': 'simpas',   
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
        else:
            flash("Invalid image file type!")
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

# loginadmin
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
                return redirect(url_for('articles'))  # Redirect ke dashboard admin
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

@app.route('/add_collector', methods=['GET', 'POST'])
def add_collector():
    if 'user_id' not in session:
        return redirect(url_for('login_admin'))  # Pastikan hanya admin yang dapat mengakses

    if request.method == 'POST':
        name = request.form['name']
        email = request.form['email']
        address = request.form['address']
        password = request.form['password']
        
        # Hash password
        hashed_password = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())

        # Simpan ke database
        connection = pymysql.connect(**db_config)
        cur = connection.cursor()
        cur.execute("INSERT INTO collectors (name, email, address, password) VALUES (%s, %s, %s, %s)", 
                    (name, email, address, hashed_password.decode('utf-8')))
        connection.commit()
        cur.close()
        connection.close()

        # Flash success message
        flash("Pengepul telah ditambahkan!", "success")
        return redirect(url_for('add_collector'))  # Redirect ke halaman add_collector

    return render_template('admin/add_collector.html')

@app.route('/collectors')
def collectors():
    if 'user_id' not in session:
        return redirect(url_for('login_admin'))  # Pastikan hanya admin yang bisa mengakses

    # Ambil data pengepul dari database
    connection = pymysql.connect(**db_config)
    cur = connection.cursor()
    cur.execute("SELECT id, name, email, address FROM collectors")
    collectors = cur.fetchall()
    cur.close()
    connection.close()

    return render_template('admin/collectors.html', collectors=collectors)

@app.route('/edit_collector/<int:id>', methods=['GET', 'POST'])
def edit_collector(id):
    if 'user_id' not in session:
        return redirect(url_for('login_admin'))

    connection = pymysql.connect(**db_config)
    cur = connection.cursor()

    if request.method == 'POST':
        name = request.form['name']
        email = request.form['email']
        address = request.form['address']
        cur.execute("UPDATE collectors SET name = %s, email = %s, address = %s WHERE id = %s",
                    (name, email, address, id))
        connection.commit()
        cur.close()
        connection.close()
        flash("Data pengepul berhasil diperbarui!", "success")
        return redirect(url_for('collectors'))

    cur.execute("SELECT id, name, email, address FROM collectors WHERE id = %s", (id,))
    collector = cur.fetchone()
    cur.close()
    connection.close()

    return render_template('admin/edit_collector.html', collector=collector)

@app.route('/delete_collector/<int:id>')
def delete_collector(id):
    if 'user_id' not in session:
        return redirect(url_for('login_admin'))

    connection = pymysql.connect(**db_config)
    cur = connection.cursor()
    cur.execute("DELETE FROM collectors WHERE id = %s", (id,))
    connection.commit()
    cur.close()
    connection.close()
    flash("Pengepul telah dihapus!", "success")
    return redirect(url_for('collectors'))

@app.route('/admin/topup_requests')
def topup_requests():
    # Pastikan admin login
    if 'user_id' not in session:
        return redirect(url_for('login_admin'))
    
    # Query untuk mengambil data top-up request beserta nama dan email pengepul
    connection = pymysql.connect(**db_config)
    cur = connection.cursor()
    cur.execute(""" 
    SELECT 
        tr.id AS topup_id,
        tr.collector_id,  -- Tambahkan collector_id di sini
        c.name AS collector_name,
        c.email AS collector_email,
        tr.transfer_proof_filename,
        tr.points,
        tr.status,
        tr.created_at
    FROM 
        topup_requests tr
    LEFT JOIN 
        collectors c
    ON 
        tr.collector_id = c.id
    """)

    topup_requests = cur.fetchall()
    cur.close()
    connection.close()
    
    # Render halaman admin dengan data top-up request
    return render_template('admin/topup_requests.html', topup_requests=topup_requests)

@app.route('/admin/update_topup_request/<int:topup_id>', methods=['POST'])
def update_topup_request(topup_id):
    if 'user_id' not in session:
        return redirect(url_for('login_admin'))
    
    # Ambil data dari form
    points = request.form.get('points')
    status = request.form.get('status')

    # Update database
    connection = pymysql.connect(**db_config)
    cur = connection.cursor()
    cur.execute(""" 
        UPDATE topup_requests 
        SET points = %s, status = %s 
        WHERE id = %s
    """, (points, status, topup_id))
    connection.commit()
    cur.close()
    connection.close()

    flash('Top-up request berhasil diperbarui!', 'success')
    return redirect(url_for('topup_requests'))

@app.route('/admin/add_points/<int:topup_id>', methods=['GET', 'POST'])
def add_points(topup_id):
    # Pastikan admin login
    if 'user_id' not in session:
        return redirect(url_for('login_admin'))
    
    connection = pymysql.connect(**db_config)
    cur = connection.cursor()

    if request.method == 'POST':
        points = request.form.get('points')
        status = request.form.get('status')
        cur.execute(""" 
            UPDATE topup_requests 
            SET points = %s, status = %s 
            WHERE id = %s 
        """, (points, status, topup_id))
        connection.commit()
        flash('Poin berhasil ditambahkan!', 'success')
        return redirect(url_for('topup_requests'))  # Fixed the URL here
    else:
        cur.execute(""" 
            SELECT id, collector_id, points, status 
            FROM topup_requests 
            WHERE id = %s 
        """, (topup_id,))
        topup_request = cur.fetchone()

    cur.close()
    connection.close()

    return render_template('admin/add_points.html', topup_request=topup_request)


@app.route('/logout')
def logout():
    session.pop('user_id', None)  # Hapus data user_id dari session
    flash("You have been logged out.", "info")
    return redirect(url_for('login_admin'))  # Redirect ke halaman login


if __name__ == '__main__':
    app.run(debug=True)
