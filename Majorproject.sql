create database collegeInformation
use collegeInformation

SP_HELPTEXT 'sp_getSubjectPracticalMarks'


----------------------------------------1)Stream table---------------

create table tblstream (streamid int identity(1,1) primary key,streamname varchar (50))

--------------------------------------1.1)Stream Procedures--------------

create proc sp_tblstream(@streamname varchar (20))
as 
insert tblstream values(@streamname)
return @@identity
select * from tblstream
----------------------------------2)Branch table--------------------------------

create table tblbranch( branchid int identity(1,1) primary key, branchname varchar(20), streamid int references tblstream )


select * from tblbranch
----------------------------------2.1Branch Procedure-------------------------------

	sp_helptext 'sp_tblbranch'
	
create proc sp_tblbranch(@branchname varchar(20), @streamid int)
as
insert tblbranch values(@branchname, @streamid)
return @@identity

sp_tblbranch 'CSE',1

---------------------------3)Sessionyear Table-----------------------------------------

create table tblsessionYears(sessionid int identity(1,1)
 not null primary key,sessionname varchar(20) )

-------------------------------sessional proc--------------------
 create proc sp_tblsessionYears( @sessionname varchar(20))
 as
 insert tblsessionYears values(@sessionname)
 return @@identity

select * from tblsessionYears

-------------------------------4)Student Table---------------------------------

create table tblstudent(rno int primary key,  
registrationid int identity, 
sname nvarchar(20),address nvarchar(20),phno varchar(30),emailid  nvarchar(30))



----------------------------------login table---------------------------------------
create table tblLogin( sname nvarchar(20),emailid nvarchar(20),pwd nvarchar(30))

select * from tblLogin

-------------------------------------- Proc Login---------------------------------

sp_rename 'tbllogin.sname','uname'

insert tblLogin values('Admin','Admin@adesh.com','admin1234',null,'Admin',null)

alter table tbllogin add rno int 

alter table tbllogin add roleName varchar(30)

alter table tbllogin alter column emailid varchar(50) not null

alter table tbllogin add primary key(emailid)

select * from tblstudent
select * from tblLogin
alter table tblLogin add ImageUrl varchar(20) 

update tblLogin set rno=0 where rno is null


create proc sp_tblLogin(@uname nvarchar(20),@emailid nvarchar(20),@pwd nvarchar(30),@rno int,@ImageUrl varchar(20))
as
if exists (select emailid from tblLogin where emailid = @emailid )
return 2
else
begin
	insert tblLogin values(@uname,@emailid,@pwd,@rno,'USER',@ImageUrl)
	return 1
end

----------------------------student proc--------------------------------------------------
create proc sp_StudentProc(@sname varchar(20),@address varchar(20),@phoneNo varchar(20),@Emailid varchar(20))
as
declare
	---local variables
	@rno int
	begin
		set @rno = (select  isnull(MAX(rno),0) from tblstudent )+1
		insert tblstudent values(@rno,@sname,@address ,@phoneNo ,@Emailid)
		
	end
select * from tblstudent

-------------------------5)Semster Table----------------------------------------
   create table tblSemester(semid int identity(101,1) primary key,
	semname varchar(20),streamid int references tblstream)
	
	select * from tblSemester
--------------------------------sem proc----------------
	create proc sp_tblSemester( @semname varchar(20),@streamid int)
	as
	insert tblSemester values(@semname,@streamid)
	return @@identity
	
	
	
	
------------------------6)student Detail-----------------------------------------
	use collegeInformation
	create table tblstudentdetails(
	rno int references tblstudent,
	semid int references tblSemester,
	sessionid int references tblsessionyears,
	branchid int references tblbranch,
	streamid int references tblstream,
	RnoSemidSessionId int identity(101,1) primary key)
	
	select * from tblstream
	select * from tblAssignments
----------------------------------------proc for student Details-----------------------
	sp_getStudentDetails 1
	
	create proc sp_getStudentDetails(@rno int)
	as
	select tblstudentdetails.RnoSemidSessionId,tblstudent.rno,sname,address, sessionName,
	 streamname, branchname, phno from tblstudent,
	tblsessionYears,tblbranch,tblstream,tblstudentdetails  
	where tblstudentdetails.rno = tblstudent.rno
	and
	tblstudentdetails.branchid = tblbranch.branchid 
	and
	tblstudentdetails.sessionid = tblsessionYears.sessionid 
	and
	tblstudentdetails.streamid = tblstream.streamid 
	and tblstudent.rno = @rno
	
--------------------------------------------------------------------------------------------------------	
	sp_rename 'sp_tblsessionmarks','sp_tblSessionalMarks'
	
---------------------------------------student table proc---------------------------------------------------------------------
	create proc sp_tblstudentdetails(@rno int,@semid int, @sessionid int,@branchid int, @streamid int )
	
	
	as
	insert tblstudentdetails values(@rno,@semid,@sessionid,@branchid,@streamid)
	return @@Identity
	
------------------------7)tbl sessional---------------------------------------------
	create table tblSessional(
	sessionalid int identity(10,1) primary key,
	sessionalname varchar(30),
	sessionaldate datetime)
	select * from tblSessional

select * from tblLogin
update tblLogin set ImageUrl ='tulips.jpg' where uname='Admin'

select * from tblSessional
-------------------------------sessional proc-----------
    create proc sp_tblSessional( @sessionalname varchar(30),@sessionaldate datetime)
    as
    insert tblSessional values ( @sessionalname,@sessionaldate)
    return @@identity
------------------------8)tblSubjects------------------------------------------------
	create table tblSubjects(
	subid int identity(1001,1) primary key,
	subjectName varchar(50))
	----------------------------sub proc-----------------
	create  proc sp_subjects(@Subjectname varchar(20))
	as
	insert tblSubjects values(@Subjectname)
	return @@identity
------------------------9)tblsessionalmarks-------------------------------------------
	create table tblsessionalmarks(
	RnoSemidSessionId int references tblstudentdetails,
	subid int references tblSubjects,
	sessionalid int references tblSessional,
	totalMarks int,
	mobt int)
	
	
	select * from tblSessional
	alter table tblSessional drop column sessionaldate
	select * from tblsessionalmarks
	
------------------------------------sessional proc--------------------
	create proc sp_tblsessionmarks(@RnoSemidSessionId int,@subid int,@sessionalid int,
	@totalMarks int,@mobt int)
	as
	insert tblsessionalmarks values(@RnoSemidSessionId,@subid,@sessionalid,@totalMarks,@mobt) 
	
------------------------10)tblAttendance------------------------------------------------
	create table tblAttendance
	(
	RnoSemidSessionId int references tblstudentdetails,
	subid int references tblSubjects,
	lecheld int,
	lecattended int)
	alter table tblAttendance add  totalmarks int
		alter table tblAttendance add  mobt int

	select * from tblAttendance
	
-------------------------------------------------------------------------
	alter table tblAttendance add  monthid int references  tblMonths

---------------------------attendance proc--------------------------------------------
	create proc sp_tblAttendance(@RnoSemidSessionId int,@subid int,@lecheld int,@lecattended int, @monthid int, @totalmarks int, @mobt int)
	as
	insert tblAttendance values (@RnoSemidSessionId, @subid, @lecheld, @lecattended, @monthid, @totalmarks, @mobt)
	

	 
	 select * from tblsessionYears
	 
	 
	 
-------------------------11)tblAssignments-------------------------------------------------
	create table tblAssignments
	(
	RnoSemidSessionId int references tblstudentdetails,
	subid int references tblSubjects,
	AssignmentGivenDate datetime,
	AssignmentSubmitDate datetime,
	assignmentMarks int,
	assignmentMarksObt int)
	
	alter table tblAssignments add assignmentID int identity
	select * from tblAssignments

---------------------------assignment proc-----------------------------------------------
	create proc sp_tblAssignments(@RnoSemidSessionId int,@subid int,@AssignmentGivenDate datetime,@AssignmentSubmitDate datetime,@assignmentMarks int,@assignmentMarksObt int )
	as
	insert tblAssignments values (@RnoSemidSessionId,@subid,@AssignmentGivenDate,@AssignmentSubmitDate,@assignmentMarks,@assignmentMarksObt )
	return @@Identity

---------------------------12)tblPracticals-------------------------------------------------
	create table tblPracticals
	(
	RnoSemidSessionId int references tblstudentdetails,
	subid int references tblSubjects,
	practicalDate datetime,
	PracticalMarks int,
	PracticalMarksObt int)
	select * from tblPracticals

----------------------------------------------practical proc-----------------
	create proc sp_tblPracticals(@RnoSemidSessionId int,@subid int,@practicaldate datetime,@PracticalMarks int,@PracticalMarksObt int )
	as
	insert tblPracticals values(@RnoSemidSessionId ,@subid ,@practicaldate ,@PracticalMarks ,@PracticalMarksObt )

------------------------------------------Get Practical Marks-----------------------
	select * from tblbranch 	select * from tblstream	select * from tblstudentdetails
	select * from tblSubjects	select * from tblPracticals 	select * from tblstudent
	
------------------------------------------------ Practicalexternal marks------------------------
create table tblPracticalsExternal
	(
	RnoSemidSessionId int references tblstudentdetails,
	subid int references tblSubjects,
	practicalDate datetime,
	PracticalExternalMarks int,
	PracticalExternalMarksObt int)
select * from tblPracticalsExternal	
	------------------------------------------- proc Practical external marks-------------
	
	create proc sp_tblPracticalsExternal(@RnoSemidSessionId int,@subid int,@practicaldate datetime,
	@PracticalExternalMarks int,@PracticalExternalMarksObt int )
	as
	insert tblPracticalsExternal values(@RnoSemidSessionId ,@subid ,@practicaldate ,
	@PracticalExternalMarks ,@PracticalExternalMarksObt )
	
	
---------------------------13)tblInternal-----------------------------------------------------
	create table tblInternalmarks(
	RnoSemidSessionId int references tblstudentdetails,
	internalmarksPercentage decimal)
	--------------------------------------internal proc----------
	
	create proc sp_tblInternalmarks(@Rnosemidsessionid int,@internalmarksPercentage int)
	as
	insert tblInternalmarks values(@Rnosemidsessionid, @internalmarksPercentage)
	------------------------------------------get internal marks--------------------
	Select * from tblAssignments
	select * from tblAttendance
	select * from tblsessionalmarks

---------------------------14)tblExternal----------------------------------------------------
	create table externalmarks(
	RnoSemidSessionId int references tblstudentdetails,
	subid int references tblSubjects,
	externalTotalMarks int,
	externalMarksObt int)  
	------------------------external proc-----------------------------------------------------------
	
	create proc sp_externalmarks(@RnoSemidSessionId int,@subid int,@externalTotalMarks int,@externalMarksObt int)
	as
	insert externalmarks values(@RnoSemidSessionId,@subid,@externalTotalMarks,@externalMarksObt)
	
----------------------------15)month table-----------------

    create table tblMonths (monthid int identity primary key, monthnm varchar(20))
	
	select * from tblSemester
----------------------------------------month proc----------------------------------
    create proc sp_tblMonths( @monthnm varchar(20))
    as
    insert tblMonths values( @monthnm)
    return @@identity
 --------------------------------------16)syallbus table------------------------
    create table tblSyallbus (streamid int references tblstream, branchid int references tblbranch,
    sessionid int references tblsessionYears,
    semid int references tblSemester, subid int references tblSubjects) 
 
    select * from tblSyallbus

 ---------------------------------syallbus proc---------------------------------
    create proc sp_tblSyallbus (@streamid int, @branchid int, @sessionid int,@semid int , @subid int )
    as 
    insert tblSyallbus values(@streamid, @branchid , @sessionid ,@semid  , @subid  )
    
    select * from  tblAssignments
    select tblstudent.rno,semid,
	avg(assignmentMarksObt) 'Assignment Average',avg(tblAttendance.mobt) 'Attendence Average', 
	avg(tblsessionalmarks.mobt) 'Sessional Average',avg(assignmentMarksObt)+avg(tblAttendance.mobt)+avg(tblsessionalmarks.mobt) 'Internal Total'
	from  tblbranch ,tblstream,tblstudentdetails,tblSubjects,
	tblstudent,tblAssignments,tblsessionalmarks ,tblAttendance, tblInternalmarks
	where 
			tblstudent .rno = tblstudentdetails.rno 
	and		tblSubjects.subid=tblAttendance.subid
	and 	tblstudentdetails.streamid=tblstream.streamid
	and  	tblstudentdetails.branchid=tblbranch.branchid
	and		tblstudentdetails.RnoSemidSessionId = tblInternalmarks.RnoSemidSessionId
	and		tblSubjects.subid = tblsessionalmarks.subid 
	and		tblSubjects.subid = tblAssignments.subid  
	group by tblstudent.rno, semid
	
	select * from tblLogin
	
	select * from tblstudent
    insert tblstudent values (1,01,'admin','patiala',
