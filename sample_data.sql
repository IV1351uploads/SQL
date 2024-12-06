-- Drop all existing data to avoid duplicates
TRUNCATE SiblingRelation, Enrollment, IndividualLesson, GroupLesson, EnsembleLesson, InstrumentRental, Payment, InstructorPayment, Lesson, PriceScheme, Classroom, Availability, Instrument, InstructorInstrument, Student, ContactDetails, ContactPerson, Address RESTART IDENTITY CASCADE;

INSERT INTO Address (Street, Zip, City)
VALUES 
('123 Main St', '12345', 'Metropolis'),
('456 Elm St', '67890', 'Gotham');

INSERT INTO ContactDetails (PhoneNumber, EmailAddress)
VALUES 
('123-456-7890', 'alice@example.com'),
('987-654-3210', 'bob@example.com');

INSERT INTO Student (FirstName, LastName, AddressID, ContactDetailsID)
VALUES 
('Alice', 'Johnson', 1, 1),
('Bob', 'Smith', 2, 2);

INSERT INTO SiblingRelation (StudentID1, StudentID2)
VALUES 
(1, 2);

INSERT INTO Instrument (InstrumentType, Brand, QuantityInStock)
VALUES 
('Guitar', 'Yamaha', 10),
('Piano', 'Roland', 5);

INSERT INTO Instructor (FirstName, LastName, AddressID, ContactDetailsID)
VALUES 
('John', 'Doe', 1, 1);

INSERT INTO Classroom (RoomNumber, Capacity)
VALUES 
('101', 20);

INSERT INTO PriceScheme (ValidFromDate, LessonType, Level, Price, InstructorFee, SiblingDiscountPercentage)
VALUES 
('2024-01-01', 'Group', 'Beginner', 30.00, 20.00, 10.00);

INSERT INTO Lesson (Level, Date, StartTime, Duration, InstructorID, ClassroomID, PriceSchemeID)
VALUES 
('Beginner', '2024-01-15', '10:00:00', 60, 1, 1, 1);

INSERT INTO Enrollment (StudentID, LessonID, EnrollmentDate)
VALUES 
(1, 1, '2024-01-10'),
(2, 1, '2024-01-11');

INSERT INTO InstrumentRental (StudentID, InstrumentID, StartDate, EndDate, RentalPeriod)
VALUES 
(1, 1, '2024-01-01', '2024-02-01', 1),
(2, 2, '2024-01-01', NULL, 2);

-- Display all table contents
SELECT * FROM Address;
SELECT * FROM ContactDetails;
SELECT * FROM ContactPerson;
SELECT * FROM Student;
SELECT * FROM SiblingRelation;
SELECT * FROM Instrument;
SELECT * FROM Instructor;
SELECT * FROM Classroom;
SELECT * FROM PriceScheme;
SELECT * FROM Lesson;
SELECT * FROM Enrollment;
SELECT * FROM InstrumentRental;

