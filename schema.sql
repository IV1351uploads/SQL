-- Drop existing tables to avoid conflicts
DROP TABLE IF EXISTS SiblingRelation, Enrollment, IndividualLesson, GroupLesson, EnsembleLesson, InstrumentRental, Payment, InstructorPayment, Lesson, PriceScheme, Classroom, Availability, Instrument, InstructorInstrument, Student, ContactDetails, ContactPerson, Address, Instructor CASCADE;

-- Address Table
CREATE TABLE Address (
    AddressID SERIAL PRIMARY KEY,
    Street VARCHAR(100) NOT NULL,
    Zip VARCHAR(10) NOT NULL,
    City VARCHAR(50) NOT NULL
);

-- ContactDetails Table
CREATE TABLE ContactDetails (
    ContactDetailsID SERIAL PRIMARY KEY,
    PhoneNumber VARCHAR(20) UNIQUE,
    EmailAddress VARCHAR(100) UNIQUE
);

-- ContactPerson Table
CREATE TABLE ContactPerson (
    ContactPersonID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    RelationToStudent VARCHAR(50),
    AddressID INT NOT NULL REFERENCES Address(AddressID),
    ContactDetailsID INT NOT NULL REFERENCES ContactDetails(ContactDetailsID)
);

-- Student Table
CREATE TABLE Student (
    StudentID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    AddressID INT NOT NULL REFERENCES Address(AddressID),
    ContactDetailsID INT NOT NULL REFERENCES ContactDetails(ContactDetailsID),
    ContactPersonID INT REFERENCES ContactPerson(ContactPersonID)
);

-- SiblingRelation Table
CREATE TABLE SiblingRelation (
    StudentID1 INT NOT NULL REFERENCES Student(StudentID),
    StudentID2 INT NOT NULL REFERENCES Student(StudentID),
    PRIMARY KEY (StudentID1, StudentID2)
);

-- Instrument Table
CREATE TABLE Instrument (
    InstrumentID SERIAL PRIMARY KEY,
    InstrumentType VARCHAR(50) NOT NULL,
    Brand VARCHAR(50) NOT NULL,
    QuantityInStock INT NOT NULL
);

-- InstrumentRental Table
CREATE TABLE InstrumentRental (
    RentalID SERIAL PRIMARY KEY,
    StudentID INT NOT NULL REFERENCES Student(StudentID),
    InstrumentID INT NOT NULL REFERENCES Instrument(InstrumentID),
    StartDate DATE NOT NULL,
    EndDate DATE,
    RentalPeriod INT CHECK (RentalPeriod BETWEEN 1 AND 12)
);

-- Instructor Table
CREATE TABLE Instructor (
    InstructorID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    AddressID INT NOT NULL REFERENCES Address(AddressID),
    ContactDetailsID INT NOT NULL REFERENCES ContactDetails(ContactDetailsID)
);

-- InstructorInstrument Table
CREATE TABLE InstructorInstrument (
    InstructorID INT NOT NULL REFERENCES Instructor(InstructorID),
    InstrumentID INT NOT NULL REFERENCES Instrument(InstrumentID),
    CanTeachEnsembles BOOLEAN NOT NULL,
    PRIMARY KEY (InstructorID, InstrumentID)
);

-- Classroom Table
CREATE TABLE Classroom (
    ClassroomID SERIAL PRIMARY KEY,
    RoomNumber VARCHAR(10) NOT NULL,
    Capacity INT NOT NULL
);

-- PriceScheme Table
CREATE TABLE PriceScheme (
    PriceSchemeID SERIAL PRIMARY KEY,
    ValidFromDate DATE NOT NULL,
    LessonType VARCHAR(20) NOT NULL,
    Level VARCHAR(20) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    InstructorFee DECIMAL(10, 2) NOT NULL,
    SiblingDiscountPercentage DECIMAL(5, 2) NOT NULL
);

-- Lesson Table
CREATE TABLE Lesson (
    LessonID SERIAL PRIMARY KEY,
    Level VARCHAR(20) NOT NULL,
    Date DATE NOT NULL,
    StartTime TIME NOT NULL,
    Duration INT NOT NULL,
    InstructorID INT NOT NULL REFERENCES Instructor(InstructorID),
    ClassroomID INT NOT NULL REFERENCES Classroom(ClassroomID),
    PriceSchemeID INT NOT NULL REFERENCES PriceScheme(PriceSchemeID)
);

-- IndividualLesson Table
CREATE TABLE IndividualLesson (
    LessonID INT PRIMARY KEY REFERENCES Lesson(LessonID)
);

-- GroupLesson Table
CREATE TABLE GroupLesson (
    LessonID INT PRIMARY KEY REFERENCES Lesson(LessonID),
    MinAttendees INT NOT NULL,
    MaxAttendees INT NOT NULL,
    InstrumentID INT NOT NULL REFERENCES Instrument(InstrumentID)
);

-- EnsembleLesson Table
CREATE TABLE EnsembleLesson (
    LessonID INT PRIMARY KEY REFERENCES Lesson(LessonID),
    MinAttendees INT NOT NULL,
    MaxAttendees INT NOT NULL,
    Genre VARCHAR(50) NOT NULL
);

-- Enrollment Table
CREATE TABLE Enrollment (
    EnrollmentID SERIAL PRIMARY KEY,
    StudentID INT NOT NULL REFERENCES Student(StudentID),
    LessonID INT NOT NULL REFERENCES Lesson(LessonID),
    EnrollmentDate DATE NOT NULL
);

-- Payment Table
CREATE TABLE Payment (
    PaymentID SERIAL PRIMARY KEY,
    StudentID INT NOT NULL REFERENCES Student(StudentID),
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentDate DATE NOT NULL,
    BillingPeriodStart DATE NOT NULL,
    BillingPeriodEnd DATE NOT NULL
);

-- InstructorPayment Table
CREATE TABLE InstructorPayment (
    InstructorPaymentID SERIAL PRIMARY KEY,
    InstructorID INT NOT NULL REFERENCES Instructor(InstructorID),
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentDate DATE NOT NULL,
    BillingPeriodStart DATE NOT NULL,
    BillingPeriodEnd DATE NOT NULL
);

-- Availability Table
CREATE TABLE Availability (
    AvailabilityID SERIAL PRIMARY KEY,
    InstructorID INT NOT NULL REFERENCES Instructor(InstructorID),
    AvailableDate DATE NOT NULL,
    StartTime TIME NOT NULL,
    EndTime TIME NOT NULL,
    InstrumentID INT REFERENCES Instrument(InstrumentID)
);
