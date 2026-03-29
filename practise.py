import mysql.connector

try:
    connection = mysql.connector.connect(
        host='localhost',
        user='root',
        password='password',
        database='student_info'
    )
    if connection.is_connected():
        print("Connected to MySQL database")

except mysql.connector.Error as err:
    print(f"Error: {err}")

## Execute a query
cursor= connection.cursor()

query="SELECT * FROM student_performance"
cursor.execute(query)
print("Query executed successfully")

## Fetching data
results= cursor.fetchall()
for row in results:
    print(row)

## top 5 students based on their performance
query_top_students = "SELECT student_name, marks FROM student_performance ORDER BY marks DESC LIMIT 5"
cursor.execute(query_top_students)

# Fetch and print the top 5 students
top_students = cursor.fetchall()
print("Top 5 students based on their performance:")
for student in top_students:    
    print(student)

## Students less than 75 attendance
query_low_attendance = "SELECT student_name, attendance FROM student_performance WHERE attendance < 75"
cursor.execute(query_low_attendance)    

low_attendance_students = cursor.fetchall()
print("Students with attendance less than 75:")
for student in low_attendance_students:
    print(student)

## Close the connection
if connection.is_connected():
    cursor.close()
    connection.close()
    print("MySQL connection closed")
