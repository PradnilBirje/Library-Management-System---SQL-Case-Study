#LIBRARY MANAGEMENT SYSTEM
Create database Library;
use library;
create table books(BookID int primary key,Title varchar(30) not null,Author varchar(30),PublicationYear year,
Genre varchar(30));
select * from books;

insert into books values(101,"Bhagawad geeta","Ram","2005","Cultural"),
(102,"The Ice and Fire","George R R martin","1990","Historic"),(103,"The clash of kings","Sitaraman","1995","Adventure"),
(104,"Thermodynamics","S.L.Ghavale","1991","science"),(105,"Material Propeties","varad takke","1997","science"),
(106,"Automobile engineering","K.K.Lagaad","2005","Technology"),(107,"Pride & prejustice","Jane austen","2002","Time travel"),
(108,"Treasure island","stevenson","1990","Adventure"),(109,"The Tempst","shakespere","2006","suspense"),
(110,"Romeo and juliet","shakespere","1970","Fantasy");
desc books;

create table Members(MemberID int primary key,Firstname varchar(30) not null,Lastname varchar(30) not null,
Email varchar(30),Membershipdate date);
select * from members;

insert into members values(201,"Tina","Patil","tina.patil@gmail.com","2018-01-02"),
(202,"Sita","singh","sita.singh@gmail.com","2019-01-02"),
(203,"Karan","Gupta","Karan.gupta@gmail.com","2020-01-02"),
(204,"Akash","save","karan.save@gmail.com","2020-02-02"),
(205,"Varun","mangaonkar","varun.magaonkar@gmail","2022-02-03"),
(206,"Bhushan","Dubey","bhushan.dubey@gmail.com","2022-03-04"),
(207,"Jinal","Shah","jinal.shah@gmail.com","2023-03-01"),
(208,"Sweenal","Dedu","sweenal.dedu@gmail.com","2023-03-04"),
(209,"sakshi","Ray","sakshi.ray@gmail.com","2023-02-05"),
(210,"Pari","Thakur","pari.thakur@gmail.com","2023-05-05");

create table Loans(LoanID int primary key,BookID int,MemberID int,
foreign key (BookID) references books (BookID),
foreign key (MemberID) references members (MemberID),
LoanDate date,ReturnDate date);

INSERT INTO Loans (LoanID, BookID, MemberID, LoanDate, ReturnDate) VALUES
(8001, 103, 202, '2024-05-06', NULL),
(8002, 101, 202, '2024-04-05', NULL),
(8003, 104, 202, '2024-04-09', NULL),
(8004, 102, 202, '2024-02-03', '2024-10-17'),
(8005, 105, 202, '2024-02-10', '2024-10-22'),
(8006, 109, 202, '2024-01-28', '2024-10-04'),
(8007, 106, 204, '2023-12-30', NULL),
(8008, 107, 205, '2023-12-29', NULL),
(8009, 108, 207, '2024-02-03', '2024-10-10'),
(8010, 101, 207, '2024-03-03', '2024-09-30'),
(8011, 102, 207, '2024-04-04', '2024-10-16'),
(8012, 103, 207, '2024-04-04', '2024-10-16'),
(8013, 106, 207, '2024-04-04', '2024-10-16'),
(8014, 109, 207, '2024-04-04', '2024-10-16'),
(8015, 108, 206, '2024-01-15', '2024-10-02');
set sql_safe_updates=0;

select * from loans;

create table Authors(AuthorID int primary key,AuthorName varchar(25),BirthYear year);
insert into authors values(2001,"Ram","1965"),(2002,"George R R martin","1950"),(2003,"Sitaraman","1990"),(2004,"S L Ghavale","1947"),
(2005,"varad takke","1985"),(2006,"K.K.Lagad","1990"),(2007,"Jane austen","2003"),(2008,"stvenson","2003"),(2009,"shakespere","1960"),
(2010,"shakespere","1960");

select * from Authors;

create table BookAuthors(BookID int,AuthorID int,
foreign key (BookID) references books (BookID),
foreign key (AuthorID) references authors (AuthorID));

insert into BookAuthors values(101,2001),(102,2002),(103,2003),(104,2004),(105,2005),
(106,2006),(107,2007),(108,2008),(109,2009),(110,2010);

select *from Bookauthors;

create table Fines(FineID int primary key,LoanID int,
Fine_amount dec(7,2),Paid_Date date,
Foreign key(LoanID) references Loans (LoanID));

insert into Fines values(3001,8004,900,"2024-10-27"),
(3002,8005,1000,"2024-10-28"),
(3003,8006,650,"2024-10-29"),
(3004,8009,750,"2024-10-25"),
(3005,8010,1200,"2024-10-28"),
(3006,8011,500,"2024-10-27"),
(3007,8012,1200,"2024-10-27"),
(3008,8013,650,"2024-10-22"),
(3009,8014,1000,"2024-10-21"),
(3010,8015,500,"2024-10-19");

select * from fines;

insert into books values(111,"Science and fiction","sima","2005","physics");
insert into books values(112,"The origin of species science","K martin","1990","History & science");

insert into authors values(2011,"sima",1975),(2012,"k martin",1980);
insert into BookAuthors values(111,2011),(112,2012);


#QUESTIONS
#Write a query to select all books published before 2000 from the Books table.
Select *from books where publicationYear<2000;

use library;

#Write a query to select all Loans where the LoanDate is in 2024 and the ReturnDate is NULL.
SELECT *
FROM Loans
WHERE YEAR(LoanDate) = 2024 AND ReturnDate IS NULL;
  
#Write a query to select all Books where the Title contains 'Science'.
select * from books where title like "%science%";

#Write a query to select Title and a new column Availability from the Books table.. 
#If a book has been loaned out (i.e., exists in Loans table with a NULL ReturnDate), set Availability to 'Checked Out', otherwise 'Available'.

SELECT 
    b.Title,
    CASE 
        WHEN l.ReturnDate IS NULL THEN 'Checked Out'
        ELSE 'Available'
    END AS Availability
FROM Books b
LEFT JOIN 
    Loans l ON b.BookID = l.BookID;
    
#Write a query to find all Members who have borrowed more than 5 books. Use a subquery to find these MemberIDs.
select memberID,Firstname,lastname from members where memberID in
(select memberID from loans group by memberID having count(bookid)>5);

#Write a query to get the total number of books borrowed by each Member. Group the results by MemberID.
select memberid, count(bookid)"Total Books borrowed" from loans group by memberid;

#Write a query to get the total FineAmount collected for each LoanID, 
#but only include loans where the total fine amount is greater than $10. Use the HAVING clause.
select loanID, sum(Fine_amount) as "Total Fine amount" from fines group by loanid having sum(Fine_amount)>841; 

#Write a query to select the top 5 most frequently borrowed books.
SELECT 
    b.BookID,
    b.Title,
    COUNT(l.BookID) AS BorrowCount
FROM 
    Books b
LEFT JOIN 
    Loans l ON b.BookID = l.BookID
GROUP BY 
    b.BookID, b.Title
ORDER BY 
    BorrowCount DESC
LIMIT 5;

#Write a query to join Loans with Books to get a list of all loans with Title, LoanDate, and ReturnDate.
select title,loandate,returndate from loans join books using(bookid);

#Write a query to get a list of all Books and any associated loans. Include books that might not be currently borrowed.
select bookid,title,loanid,loandate,returndate from books left outer join loans using(bookid);

#Write a query to get the total number of books each Author has written. 
#Use an INNER JOIN between Books and BookAuthors, and group by AuthorID.
select bookid,title,authorid,author from books join bookauthors using(bookid);

use library;

#Write a query to find all Books that were written by authors born after 1970. 
#Use a subquery in the WHERE clause to find these AuthorIDs.
SELECT b.BookID, b.Title
FROM Books b
JOIN Authors a ON b.Author = a.Authorname
WHERE a.BirthYear > 1970;

#Write a query to list Title, AuthorName, and FineAmount for all books where a fine has been recorded. 
#Use INNER JOIN and LEFT JOIN as necessary to get all required details.
select b.title,b.Author,f.Fine_amount from books b
inner join loans l on b.bookid = l.bookid
left join fines f using(loanid)
where f.fine_amount is not null;

