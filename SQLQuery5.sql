use Hotel

create table HotelInformation (
	Id int IDENTITY(1,1) PRIMARY KEY,
	Name nvarchar(200) NOT NULL,
	Adress nvarchar(200) NOT NULL,
	OwnerName nvarchar(100),
	PhoneNumber nvarchar(12),
	TelefoneNumber nvarchar(11),
	Email nvarchar(200)
)

create table Employers (
	OIB nvarchar(11) PRIMARY KEY,
	FirstName nvarchar(100) NOT NULL,
	LastName nvarchar(100) NOT NULL,
	DateOfBirth date NOT NULL,
	Gender nvarchar(6) NOT NULL CHECK(Gender = 'Male' OR Gender = 'Female'),
	Adress nvarchar(200) NOT NULL,
	TypeOfEmployment nvarchar(50) NOT NULL,
	HourlyPay int NOT NULL,
	HotelId int FOREIGN KEY REFERENCES HotelInformation(Id) NOT NULL
)


create table HotelRooms (
	Id int IDENTITY(1,1) PRIMARY KEY,
	Number int NOT NULL UNIQUE(Number),
	Category nvarchar(100) NOT NULL,
	AccommodationPrice int NOT NULL,
	Capacity int NOT NULL CHECK(Capacity < 6),
	HotelId int FOREIGN KEY REFERENCES HotelInformation(Id) NOT NULL
)

create table Accommodation (
	Id int IDENTITY(1,1) PRIMARY KEY,
	DateOfArrival date NOT NULL,
	TimeOfArrival time NOT NULL,
	DateOfDeparture date NOT NULL,
	TimeOfDeparture time NOT NULL,
	TypeOfService nvarchar(15) NOT NULL,
	PriceOfService int NOT NULL,
	HotelRoomsId int FOREIGN KEY REFERENCES HotelRooms(Id) NOT NULL,
)
create table Guests (
	Id nvarchar(20) PRIMARY KEY,
	FirstName nvarchar(100) NOT NULL,
	LastName nvarchar(100) NOT NULL,
	DateOfBirth date NOT NULL CHECK(DateOfBirth < CURRENT_TIMESTAMP),
	Gender nvarchar(6) NOT NULL CHECK(Gender = 'Male' OR Gender = 'Female'),
	Adress nvarchar(200) NOT NULL,
	AccommodationId int FOREIGN KEY REFERENCES Accommodation(Id) NOT NULL
)
create table Buyer (
	Id int IDENTITY(1,1) PRIMARY KEY,
	FirstName nvarchar(100) NOT NULL,
	LastName nvarchar(100) NOT NULL,
	Email nvarchar(200),
)

create table Receipt(
	AccommodationId int FOREIGN KEY REFERENCES Accommodation(Id) NOT NULL,
	BuyerId int FOREIGN KEY REFERENCES Buyer(Id) NOT NULL,
	TotalPrice int NOT NULL,
	DateOfIssue date NOT NULL,
	CONSTRAINT ReceiptId PRIMARY KEY(AccommodationId, BuyerId)
)
alter table Receipt add constraint AccommodationResctriction UNIQUE(AccommodationId)
alter table Receipt alter column TotalPrice int

insert into HotelInformation(Name, Adress, OwnerName, PhoneNumber, TelefoneNumber, Email)
values
('Hotel A','Adresa 1', 'Ivan Ivi?', '091-391-2000', '021-320-456', 'hotelA@gmail.com'),
('Hotel B','Adresa 2', 'Ivan Ivi?', '091-392-3000', '021-453-777', 'hotelB@gmail.com'),
('Hotel C','Adresa 3', 'Lucia Vukorepa', '091-393-4000', '021-431-555', 'hotelC@gmail.com'),
('Hotel D','Adresa 4', 'Matija Mati?', '091-394-5000', '021-312-222', 'hotelD@gmail.com'),
('Hotel E','Adresa 5', 'Ivan Belas', '091-391-2000', '021-901-111', 'hotelE@gmail.com')

insert into Employers(OIB, FirstName, LastName, DateOfBirth, Gender, Adress, TypeOfEmployment, HourlyPay, HotelId)
values
('12345678911', 'Ante', 'Anti?', '2001-01-01', 'Male', 'Adresa A', 'Recepcionist', 30, 1),
('12345678922', 'Mate', 'Mati?', '2000-02-02', 'Male', 'Adresa B', 'Portir', 26, 2),
('12345678933', 'Marija', 'Mari?', '1998-03-03', 'Female', 'Adresa C', '?ista?ica', 30, 2),
('12345678944', 'Ana', 'Ani?', '1998-04-04', 'Female', 'Adresa D', '?ista?ica', 30, 3),
('12345678955', 'Krešo', 'Kreši?', '1995-06-06', 'Male', 'Adresa E', 'Portir', 26, 1)
insert into HotelRooms(Number, Category, AccommodationPrice, Capacity, HotelId)
values
(1, 'Kategorija A', 200, 4, 2),
(2, 'Kategorija B', 150, 3, 2),
(3, 'Kategorija E', 150, 3, 3),
(4, 'Kategorija C', 100, 2, 3),
(5, 'Kategorija A', 200, 4, 1)

insert into Accommodation(DateOfArrival, TimeOfArrival, DateOfDeparture, TimeOfDeparture, TypeOfService, PriceOfService, HotelRoomsId)
values
('2020-01-03', '10:00', '2020-01-07', '13:00', 'PoluPansion', '100', 1),
('2020-02-09', '10:00', '2020-02-13', '13:00', 'PoluPansion', '100', 1),
('2019-08-23', '10:00', '2019-08-29', '13:00', 'PuniPansion', '350', 4),
('2019-04-21', '10:00', '2019-04-29', '13:00', 'PuniPansion', '350', 2),
('2020-12-01', '10:00', '2020-12-07', '13:00', 'Regural Stay', '0', 5)

insert into Guests(Id, FirstName, LastName, DateOfBirth, Gender, Adress, AccommodationId)
values
('12345678966', 'Vedran', 'Vderi?', '2001-01-09', 'Male', 'Adresa F', 4),
('12345678977', 'Horvat', 'Horvati?', '1993-02-05', 'Male', 'Adresa G', 4),
('12345678988', 'Marijana', 'Mandi?', '1980-07-03', 'Female', 'Adresa N', 2),
('12345678999', 'Ana', 'Ani?', '1991-12-04', 'Female', 'Adresa M', 1),
('12345678912', 'Krešo', 'Kristi?', '1990-11-10', 'Male', 'Adresa O', 3)

insert into Buyer(FirstName, LastName, Email)
values
('Sanja', 'Sanji?', 'sanjasanjic@gmail.com'),
('Sanja', 'Sanji?', 'sanjasanjic@gmail.com'),
('Marko', 'Marki?', 'markomarkic@gmail.com'),
('Izabela', 'Izi?', 'izabelaizic@gmail.com'),
('Sani', 'Sani?', 'sanisanic@gmail.com')

insert into Receipt(AccommodationId, BuyerId, TotalPrice, DateOfIssue) 
values
(1, 1, 0, '2020-01-01'),
(2, 1, 0, '2020-02-03'),
(3, 2, 0, '2019-06-15'),
(4, 4, 0, '2019-03-19'),
(5, 5, 0, '2020-11-03')

update Receipt
set Receipt.TotalPrice = (HotelRooms.AccommodationPrice + Accommodation.PriceOfService) * DATEDIFF(day, Accommodation.DateOfArrival, Accommodation.DateOfDeparture)
from Receipt inner join (HotelRooms inner join Accommodation on HotelRooms.Id = Accommodation.HotelRoomsId) on Receipt.AccommodationId = Accommodation.Id

select Number, Category, AccommodationPrice, Capacity
from HotelInformation inner join HotelRooms 
on HotelInformation.Id = HotelRooms.HotelId
where HotelInformation.Name = 'Hotel B'
order by(HotelRooms.Number)


select * 
from HotelRooms
where CAST(Number as char) LIKE '1%'


select FirstName, LastName
from HotelInformation inner join Employers
on HotelInformation.Id = Employers.HotelId
where HotelId = 2 and Employers.TypeOfEmployment = '?ista?ica'


select * 
from Receipt
where DateOfIssue > '2020-12-01' and TotalPrice > 1000


select * 
from Accommodation
where DateOfArrival < CURRENT_TIMESTAMP and DateOfDeparture > CURRENT_TIMESTAMP


delete 
from Accommodation
where DateOfDeparture < '2020-01-01'


update HotelRooms
set HotelRooms.Capacity = 4
from HotelInformation inner join HotelRooms on HotelInformation.Id = HotelRooms.HotelId
where HotelInformation.Id = 2 and HotelRooms.Capacity = 3


select DateOfArrival, TimeOfArrival, DateOfDeparture, TimeOfDeparture
from Accommodation inner join HotelRooms on Accommodation.HotelRoomsId = HotelRooms.Id
where HotelRooms.Id = 3
order by (DateOfArrival)


select DateOfArrival, TimeOfArrival, DateOfDeparture, TimeOfDeparture, TypeOfService
from Accommodation inner join (HotelInformation inner join HotelRooms on  HotelInformation.Id = HotelRooms.HotelId) on Accommodation.HotelRoomsId = HotelRooms.Id
where (Accommodation.TypeOfService = 'PuniPansion' or Accommodation.TypeOfService = 'PoluPansion') and HotelInformation.Id = 3


insert into Employers(OIB, FirstName, LastName, DateOfBirth, Gender, Adress, TypeOfEmployment, HourlyPay, HotelId)
values
('12345678923', 'Mirko', 'Mirki?', '1997-11-20', 'Male', 'Adresa J', 'Sobna polsuga', 40, 1),
('12345678945', 'Nina', 'Nini?', '1997-11-03', 'Female', 'Adresa H', 'Sobna posluga', 40, 4)

update Employers
set TypeOfEmployment = 'Recepcionarka'
where OIB = '12345678945'

update Employers
set TypeOfEmployment = 'Recepcionar'
where OIB = '12345678923'
