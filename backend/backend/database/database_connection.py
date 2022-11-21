import MySQLdb as mc


def connect():
    print("Connecting")
    cnx = None
    try:
        conn= mc.connect(host='bookshop.mysql.database.azure.com',user='bazy',password='Danych1%',db='bookshopdb', ssl_mode="VERIFY_IDENTITY",
        ssl={
            'ca': "DigiCertGlobalRootCA.crt.pem"
        })
    except Exception:
        print("Not connected")
    print("Connected")
    
    cur = conn.cursor()

    answ=cur.execute("Select * from bookshopdb.books")
    result = cur.fetchall()
    for a in result:
        print(a)

    cur.close()
    conn.close()

    











    return cnx




"""
cnx = mysql.connector.connect(user="bazy", password="{your_password}", host="bookshop.mysql.database.azure.com", port=3306, database="{your_database}", 
ssl_ca="{ca-cert filename}", ssl_disabled=False)
"""
