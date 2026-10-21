
CREATE TABLE [Attendance]
( 
	[AttendanceID]       int  IDENTITY ( 1,1 )  NOT NULL ,
	[EnrollmentID]       int  NOT NULL ,
	[AttendanceDate]     date  NOT NULL ,
	[Status]             nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[Remarks]            nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL 
)
go

ALTER TABLE [Attendance]
	 WITH CHECK ADD CONSTRAINT [CK_Attendance_Status] CHECK  ( [Status]='Excused' OR [Status]='Late' OR [Status]='Absent' OR [Status]='Present' )
go

CREATE TABLE [Classrooms]
( 
	[ClassroomID]        int  IDENTITY ( 1,1 )  NOT NULL ,
	[Building]           nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[RoomNumber]         nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[Capacity]           smallint  NOT NULL 
)
go

ALTER TABLE [Classrooms]
	 WITH CHECK ADD CONSTRAINT [CK_Classrooms_Capacity] CHECK  ( [Capacity]>(0) )
go

CREATE TABLE [Courses]
( 
	[CourseID]           int  IDENTITY ( 1,1 )  NOT NULL ,
	[DepartmentID]       int  NOT NULL ,
	[CourseCode]         nvarchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[CourseName]         nvarchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[Credits]            tinyint  NOT NULL ,
	[Description]        nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL 
)
go

ALTER TABLE [Courses]
	 WITH CHECK ADD CONSTRAINT [CK_Courses_Credits] CHECK  ( Credits BETWEEN 1 AND 10 )
go

CREATE TABLE [CourseSections]
( 
	[SectionID]          int  IDENTITY ( 1,1 )  NOT NULL ,
	[CourseID]           int  NOT NULL ,
	[SemesterID]         int  NOT NULL ,
	[InstructorID]       int  NOT NULL ,
	[ClassroomID]        int  NULL ,
	[SectionCode]        nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[DayOfWeek]          nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[StartTime]          time(7)  NULL ,
	[EndTime]            time(7)  NULL ,
	[MaxStudents]        smallint  NOT NULL 
	CONSTRAINT [DF_Sections_Max]
		 DEFAULT  30
)
go

ALTER TABLE [CourseSections]
	 WITH CHECK ADD CONSTRAINT [CK_Sections_Day] CHECK  ( [DayOfWeek]='Sun' OR [DayOfWeek]='Sat' OR [DayOfWeek]='Fri' OR [DayOfWeek]='Thu' OR [DayOfWeek]='Wed' OR [DayOfWeek]='Tue' OR [DayOfWeek]='Mon' )
go

ALTER TABLE [CourseSections]
	 WITH CHECK ADD CONSTRAINT [CK_Sections_Max] CHECK  ( [MaxStudents]>(0) )
go

CREATE TABLE [Customers]
( 
	[customersALES]      nchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL 
)
go

CREATE TABLE [Departments]
( 
	[DepartmentID]       int  IDENTITY ( 1,1 )  NOT NULL ,
	[DepartmentName]     nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[Building]           nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[Phone]              nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL 
)
go

CREATE TABLE [Enrollments]
( 
	[EnrollmentID]       int  IDENTITY ( 1,1 )  NOT NULL ,
	[StudentID]          int  NOT NULL ,
	[SectionID]          int  NOT NULL ,
	[EnrollmentDate]     date  NOT NULL 
	CONSTRAINT [DF_Enroll_Date]
		 DEFAULT  CONVERT([date],getdate()),
	[Grade]              nvarchar(2) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[GradePoints]        decimal(3,2)  NULL ,
	[Status]             nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL 
	CONSTRAINT [DF_Enroll_Status]
		 DEFAULT  'Enrolled'
)
go

ALTER TABLE [Enrollments]
	 WITH CHECK ADD CONSTRAINT [CK_Enroll_Grade] CHECK  ( [Grade]='I' OR [Grade]='W' OR [Grade]='F' OR [Grade]='D' OR [Grade]='C-' OR [Grade]='C' OR [Grade]='C+' OR [Grade]='B-' OR [Grade]='B' OR [Grade]='B+' OR [Grade]='A-' OR [Grade]='A' )
go

ALTER TABLE [Enrollments]
	 WITH CHECK ADD CONSTRAINT [CK_Enroll_Points] CHECK  ( GradePoints BETWEEN 0 AND 4 )
go

ALTER TABLE [Enrollments]
	 WITH CHECK ADD CONSTRAINT [CK_Enroll_Status] CHECK  ( [Status]='Dropped' OR [Status]='Completed' OR [Status]='Enrolled' )
go

CREATE TABLE [Instructors]
( 
	[InstructorID]       int  IDENTITY ( 1,1 )  NOT NULL ,
	[DepartmentID]       int  NOT NULL ,
	[FirstName]          nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[LastName]           nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[Email]              nvarchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[Phone]              nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[HireDate]           date  NOT NULL ,
	[Title]              nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL 
)
go

CREATE TABLE [Programs]
( 
	[ProgramID]          int  IDENTITY ( 1,1 )  NOT NULL ,
	[DepartmentID]       int  NOT NULL ,
	[ProgramName]        nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[DegreeLevel]        nvarchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[DurationYears]      tinyint  NOT NULL 
)
go

ALTER TABLE [Programs]
	 WITH CHECK ADD CONSTRAINT [CK_Programs_Level] CHECK  ( [DegreeLevel]='PhD' OR [DegreeLevel]='Master' OR [DegreeLevel]='Bachelor' OR [DegreeLevel]='Diploma' )
go

ALTER TABLE [Programs]
	 WITH CHECK ADD CONSTRAINT [CK_Programs_Duration] CHECK  ( DurationYears BETWEEN 1 AND 8 )
go

CREATE TABLE [Semesters]
( 
	[SemesterID]         int  IDENTITY ( 1,1 )  NOT NULL ,
	[SemesterName]       nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[StartDate]          date  NOT NULL ,
	[EndDate]            date  NOT NULL 
)
go

CREATE TABLE [Students]
( 
	[StudentID]          int  IDENTITY ( 1000,1 )  NOT NULL ,
	[ProgramID]          int  NOT NULL ,
	[FirstName]          nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[LastName]           nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[Email]              nvarchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[Phone]              nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[DateOfBirth]        date  NOT NULL ,
	[Gender]             char(1) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[Address]            nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[EnrollmentDate]     date  NOT NULL 
	CONSTRAINT [DF_Students_EnrollDate]
		 DEFAULT  CONVERT([date],getdate()),
	[Status]             nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL 
	CONSTRAINT [DF_Students_Status]
		 DEFAULT  'Active'
)
go

ALTER TABLE [Students]
	 WITH CHECK ADD CONSTRAINT [CK_Students_Gender] CHECK  ( [Gender]='O' OR [Gender]='F' OR [Gender]='M' )
go

ALTER TABLE [Students]
	 WITH CHECK ADD CONSTRAINT [CK_Students_Status] CHECK  ( [Status]='Withdrawn' OR [Status]='Suspended' OR [Status]='Graduated' OR [Status]='Active' )
go

ALTER TABLE [Attendance]
	ADD CONSTRAINT [PK_Attendance] PRIMARY KEY  CLUSTERED ([AttendanceID] ASC)
go

ALTER TABLE [Attendance]
	ADD CONSTRAINT [UQ_Attendance] UNIQUE ([EnrollmentID]  ASC,[AttendanceDate]  ASC)
go

ALTER TABLE [Classrooms]
	ADD CONSTRAINT [PK_Classrooms] PRIMARY KEY  CLUSTERED ([ClassroomID] ASC)
go

ALTER TABLE [Classrooms]
	ADD CONSTRAINT [UQ_Classrooms] UNIQUE ([Building]  ASC,[RoomNumber]  ASC)
go

ALTER TABLE [Courses]
	ADD CONSTRAINT [PK_Courses] PRIMARY KEY  CLUSTERED ([CourseID] ASC)
go

ALTER TABLE [Courses]
	ADD CONSTRAINT [UQ_Courses_Code] UNIQUE ([CourseCode]  ASC)
go

ALTER TABLE [CourseSections]
	ADD CONSTRAINT [PK_CourseSections] PRIMARY KEY  CLUSTERED ([SectionID] ASC)
go

ALTER TABLE [CourseSections]
	ADD CONSTRAINT [UQ_Sections] UNIQUE ([CourseID]  ASC,[SemesterID]  ASC,[SectionCode]  ASC)
go

ALTER TABLE [Departments]
	ADD CONSTRAINT [PK_Departments] PRIMARY KEY  CLUSTERED ([DepartmentID] ASC)
go

ALTER TABLE [Departments]
	ADD CONSTRAINT [UQ_Departments_Name] UNIQUE ([DepartmentName]  ASC)
go

ALTER TABLE [Enrollments]
	ADD CONSTRAINT [PK_Enrollments] PRIMARY KEY  CLUSTERED ([EnrollmentID] ASC)
go

ALTER TABLE [Enrollments]
	ADD CONSTRAINT [UQ_Enroll] UNIQUE ([StudentID]  ASC,[SectionID]  ASC)
go

ALTER TABLE [Instructors]
	ADD CONSTRAINT [PK_Instructors] PRIMARY KEY  CLUSTERED ([InstructorID] ASC)
go

ALTER TABLE [Instructors]
	ADD CONSTRAINT [UQ_Instructors_Email] UNIQUE ([Email]  ASC)
go

ALTER TABLE [Programs]
	ADD CONSTRAINT [PK_Programs] PRIMARY KEY  CLUSTERED ([ProgramID] ASC)
go

ALTER TABLE [Programs]
	ADD CONSTRAINT [UQ_Programs] UNIQUE ([DepartmentID]  ASC,[ProgramName]  ASC)
go

ALTER TABLE [Semesters]
	ADD CONSTRAINT [PK_Semesters] PRIMARY KEY  CLUSTERED ([SemesterID] ASC)
go

ALTER TABLE [Semesters]
	ADD CONSTRAINT [UQ_Semesters_Name] UNIQUE ([SemesterName]  ASC)
go

ALTER TABLE [Students]
	ADD CONSTRAINT [PK_Students] PRIMARY KEY  CLUSTERED ([StudentID] ASC)
go

ALTER TABLE [Students]
	ADD CONSTRAINT [UQ_Students_Email] UNIQUE ([Email]  ASC)
go

CREATE NONCLUSTERED INDEX [IX_Students_LastName] ON [Students]
( 
	[LastName]            ASC,
	[FirstName]           ASC
)
go


ALTER TABLE [Attendance] WITH CHECK 
	ADD CONSTRAINT [FK_Attendance_Enrollments] FOREIGN KEY ([EnrollmentID]) REFERENCES [Enrollments]([EnrollmentID])
		ON DELETE CASCADE
		ON UPDATE NO ACTION
go

ALTER TABLE [Attendance]
	  WITH CHECK CHECK CONSTRAINT [FK_Attendance_Enrollments]
go


ALTER TABLE [Courses] WITH CHECK 
	ADD CONSTRAINT [FK_Courses_Departments] FOREIGN KEY ([DepartmentID]) REFERENCES [Departments]([DepartmentID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Courses]
	  WITH CHECK CHECK CONSTRAINT [FK_Courses_Departments]
go


ALTER TABLE [CourseSections] WITH CHECK 
	ADD CONSTRAINT  [CK_Sections_Time]
		CHECK  ( [EndTime] IS NULL OR [StartTime] IS NULL OR [EndTime]>[StartTime] ) 
go


ALTER TABLE [CourseSections] WITH CHECK 
	ADD CONSTRAINT [FK_Sections_Courses] FOREIGN KEY ([CourseID]) REFERENCES [Courses]([CourseID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [CourseSections]
	  WITH CHECK CHECK CONSTRAINT [FK_Sections_Courses]
go

ALTER TABLE [CourseSections] WITH CHECK 
	ADD CONSTRAINT [FK_Sections_Semesters] FOREIGN KEY ([SemesterID]) REFERENCES [Semesters]([SemesterID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [CourseSections]
	  WITH CHECK CHECK CONSTRAINT [FK_Sections_Semesters]
go

ALTER TABLE [CourseSections] WITH CHECK 
	ADD CONSTRAINT [FK_Sections_Instructors] FOREIGN KEY ([InstructorID]) REFERENCES [Instructors]([InstructorID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [CourseSections]
	  WITH CHECK CHECK CONSTRAINT [FK_Sections_Instructors]
go

ALTER TABLE [CourseSections] WITH CHECK 
	ADD CONSTRAINT [FK_Sections_Classrooms] FOREIGN KEY ([ClassroomID]) REFERENCES [Classrooms]([ClassroomID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [CourseSections]
	  WITH CHECK CHECK CONSTRAINT [FK_Sections_Classrooms]
go


ALTER TABLE [Enrollments] WITH CHECK 
	ADD CONSTRAINT [FK_Enroll_Students] FOREIGN KEY ([StudentID]) REFERENCES [Students]([StudentID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Enrollments]
	  WITH CHECK CHECK CONSTRAINT [FK_Enroll_Students]
go

ALTER TABLE [Enrollments] WITH CHECK 
	ADD CONSTRAINT [FK_Enroll_Sections] FOREIGN KEY ([SectionID]) REFERENCES [CourseSections]([SectionID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Enrollments]
	  WITH CHECK CHECK CONSTRAINT [FK_Enroll_Sections]
go


ALTER TABLE [Instructors] WITH CHECK 
	ADD CONSTRAINT [FK_Instructors_Departments] FOREIGN KEY ([DepartmentID]) REFERENCES [Departments]([DepartmentID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Instructors]
	  WITH CHECK CHECK CONSTRAINT [FK_Instructors_Departments]
go


ALTER TABLE [Programs] WITH CHECK 
	ADD CONSTRAINT [FK_Programs_Departments] FOREIGN KEY ([DepartmentID]) REFERENCES [Departments]([DepartmentID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Programs]
	  WITH CHECK CHECK CONSTRAINT [FK_Programs_Departments]
go


ALTER TABLE [Semesters] WITH CHECK 
	ADD CONSTRAINT  [CK_Semesters_Dates]
		CHECK  ( [EndDate]>[StartDate] ) 
go


ALTER TABLE [Students] WITH CHECK 
	ADD CONSTRAINT [FK_Students_Programs] FOREIGN KEY ([ProgramID]) REFERENCES [Programs]([ProgramID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Students]
	  WITH CHECK CHECK CONSTRAINT [FK_Students_Programs]
go


CREATE TRIGGER tD_Attendance ON Attendance FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Attendance */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Enrollments  Attendance on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="0001730e", PARENT_OWNER="", PARENT_TABLE="Enrollments"
    CHILD_OWNER="", CHILD_TABLE="Attendance"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Attendance_Enrollments", FK_COLUMNS="EnrollmentID" */
    IF EXISTS (SELECT * FROM deleted,Enrollments
      WHERE
        /* %JoinFKPK(deleted,Enrollments," = "," AND") */
        deleted.EnrollmentID = Enrollments.EnrollmentID AND
        NOT EXISTS (
          SELECT * FROM Attendance
          WHERE
            /* %JoinFKPK(Attendance,Enrollments," = "," AND") */
            Attendance.EnrollmentID = Enrollments.EnrollmentID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Attendance because Enrollments exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Attendance ON Attendance FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Attendance */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insAttendanceID int
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Enrollments  Attendance on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00018b91", PARENT_OWNER="", PARENT_TABLE="Enrollments"
    CHILD_OWNER="", CHILD_TABLE="Attendance"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Attendance_Enrollments", FK_COLUMNS="EnrollmentID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(EnrollmentID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Enrollments
        WHERE
          /* %JoinFKPK(inserted,Enrollments) */
          inserted.EnrollmentID = Enrollments.EnrollmentID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Attendance because Enrollments does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Classrooms ON Classrooms FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Classrooms */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Classrooms  CourseSections on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00011c3e", PARENT_OWNER="", PARENT_TABLE="Classrooms"
    CHILD_OWNER="", CHILD_TABLE="CourseSections"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Classrooms", FK_COLUMNS="ClassroomID" */
    IF EXISTS (
      SELECT * FROM deleted,CourseSections
      WHERE
        /*  %JoinFKPK(CourseSections,deleted," = "," AND") */
        CourseSections.ClassroomID = deleted.ClassroomID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Classrooms because CourseSections exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Classrooms ON Classrooms FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Classrooms */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insClassroomID int
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Classrooms  CourseSections on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00013b7d", PARENT_OWNER="", PARENT_TABLE="Classrooms"
    CHILD_OWNER="", CHILD_TABLE="CourseSections"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Classrooms", FK_COLUMNS="ClassroomID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ClassroomID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,CourseSections
      WHERE
        /*  %JoinFKPK(CourseSections,deleted," = "," AND") */
        CourseSections.ClassroomID = deleted.ClassroomID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Classrooms because CourseSections exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Courses ON Courses FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Courses */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Courses  CourseSections on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="000277f9", PARENT_OWNER="", PARENT_TABLE="Courses"
    CHILD_OWNER="", CHILD_TABLE="CourseSections"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Courses", FK_COLUMNS="CourseID" */
    IF EXISTS (
      SELECT * FROM deleted,CourseSections
      WHERE
        /*  %JoinFKPK(CourseSections,deleted," = "," AND") */
        CourseSections.CourseID = deleted.CourseID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Courses because CourseSections exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Departments  Courses on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Departments"
    CHILD_OWNER="", CHILD_TABLE="Courses"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Courses_Departments", FK_COLUMNS="DepartmentID" */
    IF EXISTS (SELECT * FROM deleted,Departments
      WHERE
        /* %JoinFKPK(deleted,Departments," = "," AND") */
        deleted.DepartmentID = Departments.DepartmentID AND
        NOT EXISTS (
          SELECT * FROM Courses
          WHERE
            /* %JoinFKPK(Courses,Departments," = "," AND") */
            Courses.DepartmentID = Departments.DepartmentID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Courses because Departments exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Courses ON Courses FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Courses */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insCourseID int
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Courses  CourseSections on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00029f52", PARENT_OWNER="", PARENT_TABLE="Courses"
    CHILD_OWNER="", CHILD_TABLE="CourseSections"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Courses", FK_COLUMNS="CourseID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(CourseID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,CourseSections
      WHERE
        /*  %JoinFKPK(CourseSections,deleted," = "," AND") */
        CourseSections.CourseID = deleted.CourseID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Courses because CourseSections exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Departments  Courses on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Departments"
    CHILD_OWNER="", CHILD_TABLE="Courses"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Courses_Departments", FK_COLUMNS="DepartmentID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(DepartmentID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Departments
        WHERE
          /* %JoinFKPK(inserted,Departments) */
          inserted.DepartmentID = Departments.DepartmentID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Courses because Departments does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_CourseSections ON CourseSections FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on CourseSections */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* CourseSections  Enrollments on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00065043", PARENT_OWNER="", PARENT_TABLE="CourseSections"
    CHILD_OWNER="", CHILD_TABLE="Enrollments"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Enroll_Sections", FK_COLUMNS="SectionID" */
    IF EXISTS (
      SELECT * FROM deleted,Enrollments
      WHERE
        /*  %JoinFKPK(Enrollments,deleted," = "," AND") */
        Enrollments.SectionID = deleted.SectionID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete CourseSections because Enrollments exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Classrooms  CourseSections on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Classrooms"
    CHILD_OWNER="", CHILD_TABLE="CourseSections"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Classrooms", FK_COLUMNS="ClassroomID" */
    IF EXISTS (SELECT * FROM deleted,Classrooms
      WHERE
        /* %JoinFKPK(deleted,Classrooms," = "," AND") */
        deleted.ClassroomID = Classrooms.ClassroomID AND
        NOT EXISTS (
          SELECT * FROM CourseSections
          WHERE
            /* %JoinFKPK(CourseSections,Classrooms," = "," AND") */
            CourseSections.ClassroomID = Classrooms.ClassroomID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last CourseSections because Classrooms exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Instructors  CourseSections on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Instructors"
    CHILD_OWNER="", CHILD_TABLE="CourseSections"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Instructors", FK_COLUMNS="InstructorID" */
    IF EXISTS (SELECT * FROM deleted,Instructors
      WHERE
        /* %JoinFKPK(deleted,Instructors," = "," AND") */
        deleted.InstructorID = Instructors.InstructorID AND
        NOT EXISTS (
          SELECT * FROM CourseSections
          WHERE
            /* %JoinFKPK(CourseSections,Instructors," = "," AND") */
            CourseSections.InstructorID = Instructors.InstructorID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last CourseSections because Instructors exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Semesters  CourseSections on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Semesters"
    CHILD_OWNER="", CHILD_TABLE="CourseSections"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Semesters", FK_COLUMNS="SemesterID" */
    IF EXISTS (SELECT * FROM deleted,Semesters
      WHERE
        /* %JoinFKPK(deleted,Semesters," = "," AND") */
        deleted.SemesterID = Semesters.SemesterID AND
        NOT EXISTS (
          SELECT * FROM CourseSections
          WHERE
            /* %JoinFKPK(CourseSections,Semesters," = "," AND") */
            CourseSections.SemesterID = Semesters.SemesterID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last CourseSections because Semesters exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Courses  CourseSections on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Courses"
    CHILD_OWNER="", CHILD_TABLE="CourseSections"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Courses", FK_COLUMNS="CourseID" */
    IF EXISTS (SELECT * FROM deleted,Courses
      WHERE
        /* %JoinFKPK(deleted,Courses," = "," AND") */
        deleted.CourseID = Courses.CourseID AND
        NOT EXISTS (
          SELECT * FROM CourseSections
          WHERE
            /* %JoinFKPK(CourseSections,Courses," = "," AND") */
            CourseSections.CourseID = Courses.CourseID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last CourseSections because Courses exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_CourseSections ON CourseSections FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on CourseSections */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insSectionID int
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* CourseSections  Enrollments on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0006d540", PARENT_OWNER="", PARENT_TABLE="CourseSections"
    CHILD_OWNER="", CHILD_TABLE="Enrollments"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Enroll_Sections", FK_COLUMNS="SectionID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(SectionID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Enrollments
      WHERE
        /*  %JoinFKPK(Enrollments,deleted," = "," AND") */
        Enrollments.SectionID = deleted.SectionID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update CourseSections because Enrollments exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Classrooms  CourseSections on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Classrooms"
    CHILD_OWNER="", CHILD_TABLE="CourseSections"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Classrooms", FK_COLUMNS="ClassroomID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ClassroomID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Classrooms
        WHERE
          /* %JoinFKPK(inserted,Classrooms) */
          inserted.ClassroomID = Classrooms.ClassroomID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.ClassroomID IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update CourseSections because Classrooms does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Instructors  CourseSections on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Instructors"
    CHILD_OWNER="", CHILD_TABLE="CourseSections"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Instructors", FK_COLUMNS="InstructorID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(InstructorID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Instructors
        WHERE
          /* %JoinFKPK(inserted,Instructors) */
          inserted.InstructorID = Instructors.InstructorID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update CourseSections because Instructors does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Semesters  CourseSections on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Semesters"
    CHILD_OWNER="", CHILD_TABLE="CourseSections"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Semesters", FK_COLUMNS="SemesterID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(SemesterID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Semesters
        WHERE
          /* %JoinFKPK(inserted,Semesters) */
          inserted.SemesterID = Semesters.SemesterID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update CourseSections because Semesters does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Courses  CourseSections on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Courses"
    CHILD_OWNER="", CHILD_TABLE="CourseSections"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Courses", FK_COLUMNS="CourseID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(CourseID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Courses
        WHERE
          /* %JoinFKPK(inserted,Courses) */
          inserted.CourseID = Courses.CourseID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update CourseSections because Courses does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Departments ON Departments FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Departments */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Departments  Programs on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00031708", PARENT_OWNER="", PARENT_TABLE="Departments"
    CHILD_OWNER="", CHILD_TABLE="Programs"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Programs_Departments", FK_COLUMNS="DepartmentID" */
    IF EXISTS (
      SELECT * FROM deleted,Programs
      WHERE
        /*  %JoinFKPK(Programs,deleted," = "," AND") */
        Programs.DepartmentID = deleted.DepartmentID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Departments because Programs exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Departments  Instructors on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Departments"
    CHILD_OWNER="", CHILD_TABLE="Instructors"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Instructors_Departments", FK_COLUMNS="DepartmentID" */
    IF EXISTS (
      SELECT * FROM deleted,Instructors
      WHERE
        /*  %JoinFKPK(Instructors,deleted," = "," AND") */
        Instructors.DepartmentID = deleted.DepartmentID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Departments because Instructors exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Departments  Courses on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Departments"
    CHILD_OWNER="", CHILD_TABLE="Courses"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Courses_Departments", FK_COLUMNS="DepartmentID" */
    IF EXISTS (
      SELECT * FROM deleted,Courses
      WHERE
        /*  %JoinFKPK(Courses,deleted," = "," AND") */
        Courses.DepartmentID = deleted.DepartmentID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Departments because Courses exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Departments ON Departments FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Departments */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insDepartmentID int
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Departments  Programs on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00036f7e", PARENT_OWNER="", PARENT_TABLE="Departments"
    CHILD_OWNER="", CHILD_TABLE="Programs"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Programs_Departments", FK_COLUMNS="DepartmentID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(DepartmentID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Programs
      WHERE
        /*  %JoinFKPK(Programs,deleted," = "," AND") */
        Programs.DepartmentID = deleted.DepartmentID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Departments because Programs exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Departments  Instructors on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Departments"
    CHILD_OWNER="", CHILD_TABLE="Instructors"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Instructors_Departments", FK_COLUMNS="DepartmentID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(DepartmentID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Instructors
      WHERE
        /*  %JoinFKPK(Instructors,deleted," = "," AND") */
        Instructors.DepartmentID = deleted.DepartmentID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Departments because Instructors exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Departments  Courses on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Departments"
    CHILD_OWNER="", CHILD_TABLE="Courses"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Courses_Departments", FK_COLUMNS="DepartmentID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(DepartmentID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Courses
      WHERE
        /*  %JoinFKPK(Courses,deleted," = "," AND") */
        Courses.DepartmentID = deleted.DepartmentID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Departments because Courses exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Enrollments ON Enrollments FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Enrollments */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Enrollments  Attendance on parent delete cascade */
    /* ERWIN_RELATION:CHECKSUM="00037866", PARENT_OWNER="", PARENT_TABLE="Enrollments"
    CHILD_OWNER="", CHILD_TABLE="Attendance"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Attendance_Enrollments", FK_COLUMNS="EnrollmentID" */
    DELETE Attendance
      FROM Attendance,deleted
      WHERE
        /*  %JoinFKPK(Attendance,deleted," = "," AND") */
        Attendance.EnrollmentID = deleted.EnrollmentID

    /* erwin Builtin Trigger */
    /* CourseSections  Enrollments on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="CourseSections"
    CHILD_OWNER="", CHILD_TABLE="Enrollments"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Enroll_Sections", FK_COLUMNS="SectionID" */
    IF EXISTS (SELECT * FROM deleted,CourseSections
      WHERE
        /* %JoinFKPK(deleted,CourseSections," = "," AND") */
        deleted.SectionID = CourseSections.SectionID AND
        NOT EXISTS (
          SELECT * FROM Enrollments
          WHERE
            /* %JoinFKPK(Enrollments,CourseSections," = "," AND") */
            Enrollments.SectionID = CourseSections.SectionID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Enrollments because CourseSections exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Students  Enrollments on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Students"
    CHILD_OWNER="", CHILD_TABLE="Enrollments"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Enroll_Students", FK_COLUMNS="StudentID" */
    IF EXISTS (SELECT * FROM deleted,Students
      WHERE
        /* %JoinFKPK(deleted,Students," = "," AND") */
        deleted.StudentID = Students.StudentID AND
        NOT EXISTS (
          SELECT * FROM Enrollments
          WHERE
            /* %JoinFKPK(Enrollments,Students," = "," AND") */
            Enrollments.StudentID = Students.StudentID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Enrollments because Students exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Enrollments ON Enrollments FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Enrollments */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insEnrollmentID int
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Enrollments  Attendance on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0003ed9b", PARENT_OWNER="", PARENT_TABLE="Enrollments"
    CHILD_OWNER="", CHILD_TABLE="Attendance"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Attendance_Enrollments", FK_COLUMNS="EnrollmentID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(EnrollmentID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Attendance
      WHERE
        /*  %JoinFKPK(Attendance,deleted," = "," AND") */
        Attendance.EnrollmentID = deleted.EnrollmentID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Enrollments because Attendance exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* CourseSections  Enrollments on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="CourseSections"
    CHILD_OWNER="", CHILD_TABLE="Enrollments"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Enroll_Sections", FK_COLUMNS="SectionID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(SectionID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,CourseSections
        WHERE
          /* %JoinFKPK(inserted,CourseSections) */
          inserted.SectionID = CourseSections.SectionID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Enrollments because CourseSections does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Students  Enrollments on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Students"
    CHILD_OWNER="", CHILD_TABLE="Enrollments"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Enroll_Students", FK_COLUMNS="StudentID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(StudentID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Students
        WHERE
          /* %JoinFKPK(inserted,Students) */
          inserted.StudentID = Students.StudentID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Enrollments because Students does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Instructors ON Instructors FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Instructors */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Instructors  CourseSections on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00027cae", PARENT_OWNER="", PARENT_TABLE="Instructors"
    CHILD_OWNER="", CHILD_TABLE="CourseSections"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Instructors", FK_COLUMNS="InstructorID" */
    IF EXISTS (
      SELECT * FROM deleted,CourseSections
      WHERE
        /*  %JoinFKPK(CourseSections,deleted," = "," AND") */
        CourseSections.InstructorID = deleted.InstructorID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Instructors because CourseSections exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Departments  Instructors on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Departments"
    CHILD_OWNER="", CHILD_TABLE="Instructors"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Instructors_Departments", FK_COLUMNS="DepartmentID" */
    IF EXISTS (SELECT * FROM deleted,Departments
      WHERE
        /* %JoinFKPK(deleted,Departments," = "," AND") */
        deleted.DepartmentID = Departments.DepartmentID AND
        NOT EXISTS (
          SELECT * FROM Instructors
          WHERE
            /* %JoinFKPK(Instructors,Departments," = "," AND") */
            Instructors.DepartmentID = Departments.DepartmentID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Instructors because Departments exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Instructors ON Instructors FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Instructors */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insInstructorID int
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Instructors  CourseSections on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0002a8ab", PARENT_OWNER="", PARENT_TABLE="Instructors"
    CHILD_OWNER="", CHILD_TABLE="CourseSections"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Instructors", FK_COLUMNS="InstructorID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(InstructorID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,CourseSections
      WHERE
        /*  %JoinFKPK(CourseSections,deleted," = "," AND") */
        CourseSections.InstructorID = deleted.InstructorID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Instructors because CourseSections exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Departments  Instructors on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Departments"
    CHILD_OWNER="", CHILD_TABLE="Instructors"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Instructors_Departments", FK_COLUMNS="DepartmentID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(DepartmentID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Departments
        WHERE
          /* %JoinFKPK(inserted,Departments) */
          inserted.DepartmentID = Departments.DepartmentID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Instructors because Departments does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Programs ON Programs FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Programs */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Programs  Students on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="000252a6", PARENT_OWNER="", PARENT_TABLE="Programs"
    CHILD_OWNER="", CHILD_TABLE="Students"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Students_Programs", FK_COLUMNS="ProgramID" */
    IF EXISTS (
      SELECT * FROM deleted,Students
      WHERE
        /*  %JoinFKPK(Students,deleted," = "," AND") */
        Students.ProgramID = deleted.ProgramID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Programs because Students exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Departments  Programs on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Departments"
    CHILD_OWNER="", CHILD_TABLE="Programs"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Programs_Departments", FK_COLUMNS="DepartmentID" */
    IF EXISTS (SELECT * FROM deleted,Departments
      WHERE
        /* %JoinFKPK(deleted,Departments," = "," AND") */
        deleted.DepartmentID = Departments.DepartmentID AND
        NOT EXISTS (
          SELECT * FROM Programs
          WHERE
            /* %JoinFKPK(Programs,Departments," = "," AND") */
            Programs.DepartmentID = Departments.DepartmentID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Programs because Departments exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Programs ON Programs FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Programs */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insProgramID int
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Programs  Students on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="000296bb", PARENT_OWNER="", PARENT_TABLE="Programs"
    CHILD_OWNER="", CHILD_TABLE="Students"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Students_Programs", FK_COLUMNS="ProgramID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ProgramID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Students
      WHERE
        /*  %JoinFKPK(Students,deleted," = "," AND") */
        Students.ProgramID = deleted.ProgramID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Programs because Students exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Departments  Programs on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Departments"
    CHILD_OWNER="", CHILD_TABLE="Programs"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Programs_Departments", FK_COLUMNS="DepartmentID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(DepartmentID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Departments
        WHERE
          /* %JoinFKPK(inserted,Departments) */
          inserted.DepartmentID = Departments.DepartmentID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Programs because Departments does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Semesters ON Semesters FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Semesters */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Semesters  CourseSections on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00012237", PARENT_OWNER="", PARENT_TABLE="Semesters"
    CHILD_OWNER="", CHILD_TABLE="CourseSections"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Semesters", FK_COLUMNS="SemesterID" */
    IF EXISTS (
      SELECT * FROM deleted,CourseSections
      WHERE
        /*  %JoinFKPK(CourseSections,deleted," = "," AND") */
        CourseSections.SemesterID = deleted.SemesterID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Semesters because CourseSections exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Semesters ON Semesters FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Semesters */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insSemesterID int
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Semesters  CourseSections on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00013a96", PARENT_OWNER="", PARENT_TABLE="Semesters"
    CHILD_OWNER="", CHILD_TABLE="CourseSections"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Semesters", FK_COLUMNS="SemesterID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(SemesterID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,CourseSections
      WHERE
        /*  %JoinFKPK(CourseSections,deleted," = "," AND") */
        CourseSections.SemesterID = deleted.SemesterID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Semesters because CourseSections exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Students ON Students FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Students */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Students  Enrollments on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00024501", PARENT_OWNER="", PARENT_TABLE="Students"
    CHILD_OWNER="", CHILD_TABLE="Enrollments"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Enroll_Students", FK_COLUMNS="StudentID" */
    IF EXISTS (
      SELECT * FROM deleted,Enrollments
      WHERE
        /*  %JoinFKPK(Enrollments,deleted," = "," AND") */
        Enrollments.StudentID = deleted.StudentID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Students because Enrollments exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Programs  Students on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Programs"
    CHILD_OWNER="", CHILD_TABLE="Students"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Students_Programs", FK_COLUMNS="ProgramID" */
    IF EXISTS (SELECT * FROM deleted,Programs
      WHERE
        /* %JoinFKPK(deleted,Programs," = "," AND") */
        deleted.ProgramID = Programs.ProgramID AND
        NOT EXISTS (
          SELECT * FROM Students
          WHERE
            /* %JoinFKPK(Students,Programs," = "," AND") */
            Students.ProgramID = Programs.ProgramID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Students because Programs exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Students ON Students FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Students */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insStudentID int
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Students  Enrollments on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0002923c", PARENT_OWNER="", PARENT_TABLE="Students"
    CHILD_OWNER="", CHILD_TABLE="Enrollments"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Enroll_Students", FK_COLUMNS="StudentID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(StudentID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Enrollments
      WHERE
        /*  %JoinFKPK(Enrollments,deleted," = "," AND") */
        Enrollments.StudentID = deleted.StudentID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Students because Enrollments exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Programs  Students on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Programs"
    CHILD_OWNER="", CHILD_TABLE="Students"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Students_Programs", FK_COLUMNS="ProgramID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ProgramID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Programs
        WHERE
          /* %JoinFKPK(inserted,Programs) */
          inserted.ProgramID = Programs.ProgramID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Students because Programs does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go



ALTER TABLE [dbo].[CourseSections] DROP CONSTRAINT [CK_Sections_Day]
go

ALTER TABLE [dbo].[CourseSections] DROP CONSTRAINT [CK_Sections_Max]
go

ALTER TABLE [dbo].[CourseSections] DROP CONSTRAINT [CK_Sections_Time]
go


ALTER TABLE [dbo].[CourseSections] DROP CONSTRAINT [DF_Sections_Max]
go

ALTER TABLE [dbo].[CourseSections]
DROP CONSTRAINT [FK_Sections_Courses]
go

ALTER TABLE [dbo].[CourseSections]
DROP CONSTRAINT [FK_Sections_Semesters]
go

ALTER TABLE [dbo].[CourseSections]
DROP CONSTRAINT [FK_Sections_Instructors]
go

ALTER TABLE [dbo].[CourseSections]
DROP CONSTRAINT [FK_Sections_Classrooms]
go

ALTER TABLE [dbo].[Enrollments]
DROP CONSTRAINT [FK_Enroll_Sections]
go

ALTER TABLE [dbo].[CourseSections]
DROP CONSTRAINT [PK_CourseSections]
go

ALTER TABLE [dbo].[CourseSections]
DROP CONSTRAINT [UQ_Sections]
go

DROP INDEX [UQ_Sections] ON [dbo].[CourseSections]
go

execute sp_rename '[dbo].[CourseSections]', 'CourseSectionsAALE2327000'
go

CREATE TABLE [dbo].[CourseSections]
( 
	[SectionID]          int  IDENTITY ( 1,1 )  NOT NULL ,
	[CourseID]           int  NOT NULL ,
	[SemesterID]         int  NOT NULL ,
	[InstructorID]       int  NOT NULL ,
	[ClassroomID]        int  NULL ,
	[SectionCode]        nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[DayOfWeek]          nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[StartTime]          time(7)  NULL ,
	[EndTime]            time(37)  NULL ,
	[MaxStudents]        smallint  NOT NULL 
	CONSTRAINT [DF_Sections_Max]
		 DEFAULT  30
)
ON "PRIMARY"
WITH 
(
	DATA_COMPRESSION = NONE
)
go

ALTER TABLE [dbo].[CourseSections]
	 WITH CHECK ADD CONSTRAINT [CK_Sections_Day] CHECK  ( [DayOfWeek]='Sun' OR [DayOfWeek]='Sat' OR [DayOfWeek]='Fri' OR [DayOfWeek]='Thu' OR [DayOfWeek]='Wed' OR [DayOfWeek]='Tue' OR [DayOfWeek]='Mon' )
go

ALTER TABLE [dbo].[CourseSections]
	 WITH CHECK ADD CONSTRAINT [CK_Sections_Max] CHECK  ( [MaxStudents]>(0) )
go

ALTER TABLE [dbo].[CourseSections]
ADD CONSTRAINT [PK_CourseSections] PRIMARY KEY  CLUSTERED ([SectionID] ASC)
	WITH
	(
		PAD_INDEX = OFF,
		IGNORE_DUP_KEY = OFF,
		STATISTICS_NORECOMPUTE = OFF,
		ALLOW_ROW_LOCKS = ON,
		ALLOW_PAGE_LOCKS = ON,
		DATA_COMPRESSION = NONE
	)
	 ON "PRIMARY"
go

ALTER TABLE [dbo].[CourseSections]
ADD CONSTRAINT [UQ_Sections] UNIQUE ([CourseID]  ASC,[SemesterID]  ASC,[SectionCode]  ASC)
	WITH 
	(
		PAD_INDEX = OFF,
		IGNORE_DUP_KEY = OFF,
		STATISTICS_NORECOMPUTE = OFF,
		ALLOW_ROW_LOCKS = ON,
		ALLOW_PAGE_LOCKS = ON,
		DATA_COMPRESSION = NONE
	)
	 ON "PRIMARY"
go


SET IDENTITY_INSERT [dbo].[CourseSections] ON
INSERT INTO [dbo].[CourseSections] ([SectionID], [CourseID], [SemesterID], [InstructorID], [ClassroomID], [SectionCode], [DayOfWeek], [StartTime], [EndTime], [MaxStudents]) SELECT [SectionID], [CourseID], [SemesterID], [InstructorID], [ClassroomID], [SectionCode], [DayOfWeek], [StartTime], [EndTime], [MaxStudents] FROM [dbo].CourseSectionsAALE2327000
SET IDENTITY_INSERT [dbo].[CourseSections] OFF
go

ALTER TABLE [dbo].[CourseSections] WITH CHECK 
	ADD CONSTRAINT [FK_Sections_Courses] FOREIGN KEY ([CourseID]) REFERENCES [dbo].[Courses]([CourseID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [dbo].[CourseSections]
	  WITH CHECK CHECK CONSTRAINT [FK_Sections_Courses]
go

ALTER TABLE [dbo].[CourseSections] WITH CHECK 
	ADD CONSTRAINT [FK_Sections_Semesters] FOREIGN KEY ([SemesterID]) REFERENCES [dbo].[Semesters]([SemesterID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [dbo].[CourseSections]
	  WITH CHECK CHECK CONSTRAINT [FK_Sections_Semesters]
go

ALTER TABLE [dbo].[CourseSections] WITH CHECK 
	ADD CONSTRAINT [FK_Sections_Instructors] FOREIGN KEY ([InstructorID]) REFERENCES [dbo].[Instructors]([InstructorID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [dbo].[CourseSections]
	  WITH CHECK CHECK CONSTRAINT [FK_Sections_Instructors]
go

ALTER TABLE [dbo].[CourseSections] WITH CHECK 
	ADD CONSTRAINT [FK_Sections_Classrooms] FOREIGN KEY ([ClassroomID]) REFERENCES [dbo].[Classrooms]([ClassroomID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [dbo].[CourseSections]
	  WITH CHECK CHECK CONSTRAINT [FK_Sections_Classrooms]
go


ALTER TABLE [dbo].[CourseSections] WITH CHECK 
	ADD CONSTRAINT  [CK_Sections_Time]
		CHECK  ( [EndTime] IS NULL OR [StartTime] IS NULL OR [EndTime]>[StartTime] ) 
go


ALTER TABLE [dbo].[CourseSections]
DISABLE CHANGE_TRACKING 
go

ALTER TABLE [dbo].[CourseSections]
SET ( LOCK_ESCALATION = TABLE )
go

ALTER TABLE [dbo].[Enrollments] WITH CHECK 
	ADD CONSTRAINT [FK_Enroll_Sections] FOREIGN KEY ([SectionID]) REFERENCES [dbo].[CourseSections]([SectionID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [dbo].[Enrollments]
	  WITH CHECK CHECK CONSTRAINT [FK_Enroll_Sections]
go


CREATE TRIGGER dbo.tD_CourseSections ON dbo.CourseSections FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on CourseSections */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* dbo.CourseSections  dbo.Enrollments on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0006b9db", PARENT_OWNER="dbo", PARENT_TABLE="CourseSections"
    CHILD_OWNER="dbo", CHILD_TABLE="Enrollments"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Enroll_Sections", FK_COLUMNS="SectionID" */
    IF EXISTS (
      SELECT * FROM deleted,dbo.Enrollments
      WHERE
        /*  %JoinFKPK(dbo.Enrollments,deleted," = "," AND") */
        dbo.Enrollments.SectionID = deleted.SectionID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete dbo.CourseSections because dbo.Enrollments exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* dbo.Classrooms  dbo.CourseSections on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="dbo", PARENT_TABLE="Classrooms"
    CHILD_OWNER="dbo", CHILD_TABLE="CourseSections"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Classrooms", FK_COLUMNS="ClassroomID" */
    IF EXISTS (SELECT * FROM deleted,dbo.Classrooms
      WHERE
        /* %JoinFKPK(deleted,dbo.Classrooms," = "," AND") */
        deleted.ClassroomID = dbo.Classrooms.ClassroomID AND
        NOT EXISTS (
          SELECT * FROM dbo.CourseSections
          WHERE
            /* %JoinFKPK(dbo.CourseSections,dbo.Classrooms," = "," AND") */
            dbo.CourseSections.ClassroomID = dbo.Classrooms.ClassroomID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last dbo.CourseSections because dbo.Classrooms exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* dbo.Instructors  dbo.CourseSections on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="dbo", PARENT_TABLE="Instructors"
    CHILD_OWNER="dbo", CHILD_TABLE="CourseSections"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Instructors", FK_COLUMNS="InstructorID" */
    IF EXISTS (SELECT * FROM deleted,dbo.Instructors
      WHERE
        /* %JoinFKPK(deleted,dbo.Instructors," = "," AND") */
        deleted.InstructorID = dbo.Instructors.InstructorID AND
        NOT EXISTS (
          SELECT * FROM dbo.CourseSections
          WHERE
            /* %JoinFKPK(dbo.CourseSections,dbo.Instructors," = "," AND") */
            dbo.CourseSections.InstructorID = dbo.Instructors.InstructorID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last dbo.CourseSections because dbo.Instructors exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* dbo.Semesters  dbo.CourseSections on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="dbo", PARENT_TABLE="Semesters"
    CHILD_OWNER="dbo", CHILD_TABLE="CourseSections"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Semesters", FK_COLUMNS="SemesterID" */
    IF EXISTS (SELECT * FROM deleted,dbo.Semesters
      WHERE
        /* %JoinFKPK(deleted,dbo.Semesters," = "," AND") */
        deleted.SemesterID = dbo.Semesters.SemesterID AND
        NOT EXISTS (
          SELECT * FROM dbo.CourseSections
          WHERE
            /* %JoinFKPK(dbo.CourseSections,dbo.Semesters," = "," AND") */
            dbo.CourseSections.SemesterID = dbo.Semesters.SemesterID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last dbo.CourseSections because dbo.Semesters exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* dbo.Courses  dbo.CourseSections on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="dbo", PARENT_TABLE="Courses"
    CHILD_OWNER="dbo", CHILD_TABLE="CourseSections"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Courses", FK_COLUMNS="CourseID" */
    IF EXISTS (SELECT * FROM deleted,dbo.Courses
      WHERE
        /* %JoinFKPK(deleted,dbo.Courses," = "," AND") */
        deleted.CourseID = dbo.Courses.CourseID AND
        NOT EXISTS (
          SELECT * FROM dbo.CourseSections
          WHERE
            /* %JoinFKPK(dbo.CourseSections,dbo.Courses," = "," AND") */
            dbo.CourseSections.CourseID = dbo.Courses.CourseID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last dbo.CourseSections because dbo.Courses exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER dbo.tU_CourseSections ON dbo.CourseSections FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on CourseSections */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insSectionID int
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* dbo.CourseSections  dbo.Enrollments on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00072b61", PARENT_OWNER="dbo", PARENT_TABLE="CourseSections"
    CHILD_OWNER="dbo", CHILD_TABLE="Enrollments"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Enroll_Sections", FK_COLUMNS="SectionID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(SectionID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,dbo.Enrollments
      WHERE
        /*  %JoinFKPK(dbo.Enrollments,deleted," = "," AND") */
        dbo.Enrollments.SectionID = deleted.SectionID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update dbo.CourseSections because dbo.Enrollments exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* dbo.Classrooms  dbo.CourseSections on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="dbo", PARENT_TABLE="Classrooms"
    CHILD_OWNER="dbo", CHILD_TABLE="CourseSections"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Classrooms", FK_COLUMNS="ClassroomID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ClassroomID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,dbo.Classrooms
        WHERE
          /* %JoinFKPK(inserted,dbo.Classrooms) */
          inserted.ClassroomID = dbo.Classrooms.ClassroomID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.ClassroomID IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update dbo.CourseSections because dbo.Classrooms does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* dbo.Instructors  dbo.CourseSections on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="dbo", PARENT_TABLE="Instructors"
    CHILD_OWNER="dbo", CHILD_TABLE="CourseSections"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Instructors", FK_COLUMNS="InstructorID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(InstructorID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,dbo.Instructors
        WHERE
          /* %JoinFKPK(inserted,dbo.Instructors) */
          inserted.InstructorID = dbo.Instructors.InstructorID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update dbo.CourseSections because dbo.Instructors does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* dbo.Semesters  dbo.CourseSections on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="dbo", PARENT_TABLE="Semesters"
    CHILD_OWNER="dbo", CHILD_TABLE="CourseSections"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Semesters", FK_COLUMNS="SemesterID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(SemesterID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,dbo.Semesters
        WHERE
          /* %JoinFKPK(inserted,dbo.Semesters) */
          inserted.SemesterID = dbo.Semesters.SemesterID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update dbo.CourseSections because dbo.Semesters does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* dbo.Courses  dbo.CourseSections on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="dbo", PARENT_TABLE="Courses"
    CHILD_OWNER="dbo", CHILD_TABLE="CourseSections"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Courses", FK_COLUMNS="CourseID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(CourseID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,dbo.Courses
        WHERE
          /* %JoinFKPK(inserted,dbo.Courses) */
          inserted.CourseID = dbo.Courses.CourseID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update dbo.CourseSections because dbo.Courses does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




DROP TABLE IF EXISTS [dbo].CourseSectionsAALE2327000
go

EXEC sp_tableoption '[dbo].[CourseSections]','vardecimal storage format','OFF'
go
