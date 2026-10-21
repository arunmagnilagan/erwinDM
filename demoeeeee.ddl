
CREATE TABLE [Att]
( 
	[AttID]              int  IDENTITY ( 1,1 )  NOT NULL ,
	[EnrollmentID]       int  NOT NULL ,
	[AttDate]            date  NOT NULL ,
	[Status]             nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[Remarks]            nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL 
)
go

ALTER TABLE [Att]
	 WITH CHECK ADD CONSTRAINT [CK_Attendance_Status] CHECK  ( [Status]='Excused' OR [Status]='Late' OR [Status]='Absent' OR [Status]='Present' )
go

CREATE TABLE [Crs]
( 
	[CourseID]           int  IDENTITY ( 1,1 )  NOT NULL ,
	[DepartmentID]       int  NOT NULL ,
	[CourseCode]         nvarchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[CourseName]         nvarchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[Credits]            tinyint  NOT NULL ,
	[Description]        nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL 
)
go

ALTER TABLE [Crs]
	 WITH CHECK ADD CONSTRAINT [CK_Courses_Credits] CHECK  ( Credits BETWEEN 1 AND 10 )
go

CREATE TABLE [Dept]
( 
	[DepartmentID]       int  IDENTITY ( 1,1 )  NOT NULL ,
	[DepartmentName]     nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[Building]           nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[Phone]              nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL 
)
go

CREATE TABLE [Enr]
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

ALTER TABLE [Enr]
	 WITH CHECK ADD CONSTRAINT [CK_Enroll_Grade] CHECK  ( [Grade]='I' OR [Grade]='W' OR [Grade]='F' OR [Grade]='D' OR [Grade]='C-' OR [Grade]='C' OR [Grade]='C+' OR [Grade]='B-' OR [Grade]='B' OR [Grade]='B+' OR [Grade]='A-' OR [Grade]='A' )
go

ALTER TABLE [Enr]
	 WITH CHECK ADD CONSTRAINT [CK_Enroll_Points] CHECK  ( GradePoints BETWEEN 0 AND 4 )
go

ALTER TABLE [Enr]
	 WITH CHECK ADD CONSTRAINT [CK_Enroll_Status] CHECK  ( [Status]='Dropped' OR [Status]='Completed' OR [Status]='Enrolled' )
go

CREATE TABLE [Inst]
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

CREATE TABLE [Prog]
( 
	[ProgramID]          int  IDENTITY ( 1,1 )  NOT NULL ,
	[DepartmentID]       int  NOT NULL ,
	[ProgramName]        nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[DegreeLevel]        nvarchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[DurationYears]      tinyint  NOT NULL 
)
go

ALTER TABLE [Prog]
	 WITH CHECK ADD CONSTRAINT [CK_Programs_Level] CHECK  ( [DegreeLevel]='PhD' OR [DegreeLevel]='Master' OR [DegreeLevel]='Bachelor' OR [DegreeLevel]='Diploma' )
go

ALTER TABLE [Prog]
	 WITH CHECK ADD CONSTRAINT [CK_Programs_Duration] CHECK  ( DurationYears BETWEEN 1 AND 8 )
go

CREATE TABLE [Room]
( 
	[ClassroomID]        int  IDENTITY ( 1,1 )  NOT NULL ,
	[Building]           nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[RoomNumber]         nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[Capacity]           smallint  NOT NULL 
)
go

ALTER TABLE [Room]
	 WITH CHECK ADD CONSTRAINT [CK_Classrooms_Capacity] CHECK  ( [Capacity]>(0) )
go

CREATE TABLE [Sec]
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
	[MaxStu]             smallint  NOT NULL 
	CONSTRAINT [DF_Sections_Max]
		 DEFAULT  30
)
go

ALTER TABLE [Sec]
	 WITH CHECK ADD CONSTRAINT [CK_Sections_Day] CHECK  ( [DayOfWeek]='Sun' OR [DayOfWeek]='Sat' OR [DayOfWeek]='Fri' OR [DayOfWeek]='Thu' OR [DayOfWeek]='Wed' OR [DayOfWeek]='Tue' OR [DayOfWeek]='Mon' )
go

ALTER TABLE [Sec]
	 WITH CHECK ADD CONSTRAINT [CK_Sections_Max] CHECK  ( [MaxStudents]>(0) )
go

CREATE TABLE [Sem]
( 
	[SemesterID]         int  IDENTITY ( 1,1 )  NOT NULL ,
	[SemesterName]       nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[StartDate]          date  NOT NULL ,
	[EndDate]            date  NOT NULL 
)
go

CREATE TABLE [Stu]
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

ALTER TABLE [Stu]
	 WITH CHECK ADD CONSTRAINT [CK_Students_Gender] CHECK  ( [Gender]='O' OR [Gender]='F' OR [Gender]='M' )
go

ALTER TABLE [Stu]
	 WITH CHECK ADD CONSTRAINT [CK_Students_Status] CHECK  ( [Status]='Withdrawn' OR [Status]='Suspended' OR [Status]='Graduated' OR [Status]='Active' )
go

ALTER TABLE [Att]
	ADD CONSTRAINT [PK_Attendance] PRIMARY KEY  CLUSTERED ([AttID] ASC)
go

ALTER TABLE [Att]
	ADD CONSTRAINT [UQ_Attendance] UNIQUE ([EnrollmentID]  ASC,[AttDate]  ASC)
go

ALTER TABLE [Crs]
	ADD CONSTRAINT [PK_Courses] PRIMARY KEY  CLUSTERED ([CourseID] ASC)
go

ALTER TABLE [Crs]
	ADD CONSTRAINT [UQ_Courses_Code] UNIQUE ([CourseCode]  ASC)
go

ALTER TABLE [Dept]
	ADD CONSTRAINT [PK_Departments] PRIMARY KEY  CLUSTERED ([DepartmentID] ASC)
go

ALTER TABLE [Dept]
	ADD CONSTRAINT [UQ_Departments_Name] UNIQUE ([DepartmentName]  ASC)
go

ALTER TABLE [Enr]
	ADD CONSTRAINT [PK_Enrollments] PRIMARY KEY  CLUSTERED ([EnrollmentID] ASC)
go

ALTER TABLE [Enr]
	ADD CONSTRAINT [UQ_Enroll] UNIQUE ([StudentID]  ASC,[SectionID]  ASC)
go

ALTER TABLE [Inst]
	ADD CONSTRAINT [PK_Instructors] PRIMARY KEY  CLUSTERED ([InstructorID] ASC)
go

ALTER TABLE [Inst]
	ADD CONSTRAINT [UQ_Instructors_Email] UNIQUE ([Email]  ASC)
go

ALTER TABLE [Prog]
	ADD CONSTRAINT [PK_Programs] PRIMARY KEY  CLUSTERED ([ProgramID] ASC)
go

ALTER TABLE [Prog]
	ADD CONSTRAINT [UQ_Programs] UNIQUE ([DepartmentID]  ASC,[ProgramName]  ASC)
go

ALTER TABLE [Room]
	ADD CONSTRAINT [PK_Classrooms] PRIMARY KEY  CLUSTERED ([ClassroomID] ASC)
go

ALTER TABLE [Room]
	ADD CONSTRAINT [UQ_Classrooms] UNIQUE ([Building]  ASC,[RoomNumber]  ASC)
go

ALTER TABLE [Sec]
	ADD CONSTRAINT [PK_CourseSections] PRIMARY KEY  CLUSTERED ([SectionID] ASC)
go

ALTER TABLE [Sec]
	ADD CONSTRAINT [UQ_Sections] UNIQUE ([CourseID]  ASC,[SemesterID]  ASC,[SectionCode]  ASC)
go

ALTER TABLE [Sem]
	ADD CONSTRAINT [PK_Semesters] PRIMARY KEY  CLUSTERED ([SemesterID] ASC)
go

ALTER TABLE [Sem]
	ADD CONSTRAINT [UQ_Semesters_Name] UNIQUE ([SemesterName]  ASC)
go

ALTER TABLE [Stu]
	ADD CONSTRAINT [PK_Students] PRIMARY KEY  CLUSTERED ([StudentID] ASC)
go

ALTER TABLE [Stu]
	ADD CONSTRAINT [UQ_Students_Email] UNIQUE ([Email]  ASC)
go

CREATE NONCLUSTERED INDEX [IX_Students_LastName] ON [Stu]
( 
	[LastName]            ASC,
	[FirstName]           ASC
)
go


ALTER TABLE [Att] WITH CHECK 
	ADD CONSTRAINT [FK_Attendance_Enrollments] FOREIGN KEY ([EnrollmentID]) REFERENCES [Enr]([EnrollmentID])
		ON DELETE CASCADE
		ON UPDATE NO ACTION
go

ALTER TABLE [Att]
	  WITH CHECK CHECK CONSTRAINT [FK_Attendance_Enrollments]
go


ALTER TABLE [Crs] WITH CHECK 
	ADD CONSTRAINT [FK_Courses_Departments] FOREIGN KEY ([DepartmentID]) REFERENCES [Dept]([DepartmentID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Crs]
	  WITH CHECK CHECK CONSTRAINT [FK_Courses_Departments]
go


ALTER TABLE [Enr] WITH CHECK 
	ADD CONSTRAINT [FK_Enroll_Students] FOREIGN KEY ([StudentID]) REFERENCES [Stu]([StudentID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Enr]
	  WITH CHECK CHECK CONSTRAINT [FK_Enroll_Students]
go

ALTER TABLE [Enr] WITH CHECK 
	ADD CONSTRAINT [FK_Enroll_Sections] FOREIGN KEY ([SectionID]) REFERENCES [Sec]([SectionID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Enr]
	  WITH CHECK CHECK CONSTRAINT [FK_Enroll_Sections]
go


ALTER TABLE [Inst] WITH CHECK 
	ADD CONSTRAINT [FK_Instructors_Departments] FOREIGN KEY ([DepartmentID]) REFERENCES [Dept]([DepartmentID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Inst]
	  WITH CHECK CHECK CONSTRAINT [FK_Instructors_Departments]
go


ALTER TABLE [Prog] WITH CHECK 
	ADD CONSTRAINT [FK_Programs_Departments] FOREIGN KEY ([DepartmentID]) REFERENCES [Dept]([DepartmentID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Prog]
	  WITH CHECK CHECK CONSTRAINT [FK_Programs_Departments]
go


ALTER TABLE [Sec] WITH CHECK 
	ADD CONSTRAINT  [CK_Sections_Time]
		CHECK  ( [EndTime] IS NULL OR [StartTime] IS NULL OR [EndTime]>[StartTime] ) 
go


ALTER TABLE [Sec] WITH CHECK 
	ADD CONSTRAINT [FK_Sections_Courses] FOREIGN KEY ([CourseID]) REFERENCES [Crs]([CourseID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Sec]
	  WITH CHECK CHECK CONSTRAINT [FK_Sections_Courses]
go

ALTER TABLE [Sec] WITH CHECK 
	ADD CONSTRAINT [FK_Sections_Semesters] FOREIGN KEY ([SemesterID]) REFERENCES [Sem]([SemesterID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Sec]
	  WITH CHECK CHECK CONSTRAINT [FK_Sections_Semesters]
go

ALTER TABLE [Sec] WITH CHECK 
	ADD CONSTRAINT [FK_Sections_Instructors] FOREIGN KEY ([InstructorID]) REFERENCES [Inst]([InstructorID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Sec]
	  WITH CHECK CHECK CONSTRAINT [FK_Sections_Instructors]
go

ALTER TABLE [Sec] WITH CHECK 
	ADD CONSTRAINT [FK_Sections_Classrooms] FOREIGN KEY ([ClassroomID]) REFERENCES [Room]([ClassroomID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Sec]
	  WITH CHECK CHECK CONSTRAINT [FK_Sections_Classrooms]
go


ALTER TABLE [Sem] WITH CHECK 
	ADD CONSTRAINT  [CK_Semesters_Dates]
		CHECK  ( [EndDate]>[StartDate] ) 
go


ALTER TABLE [Stu] WITH CHECK 
	ADD CONSTRAINT [FK_Students_Programs] FOREIGN KEY ([ProgramID]) REFERENCES [Prog]([ProgramID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Stu]
	  WITH CHECK CHECK CONSTRAINT [FK_Students_Programs]
go


CREATE TRIGGER tD_Att ON Att FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Att */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Enr  Att on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00014370", PARENT_OWNER="", PARENT_TABLE="Enr"
    CHILD_OWNER="", CHILD_TABLE="Att"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Attendance_Enrollments", FK_COLUMNS="EnrollmentID" */
    IF EXISTS (SELECT * FROM deleted,Enr
      WHERE
        /* %JoinFKPK(deleted,Enr," = "," AND") */
        deleted.EnrollmentID = Enr.EnrollmentID AND
        NOT EXISTS (
          SELECT * FROM Att
          WHERE
            /* %JoinFKPK(Att,Enr," = "," AND") */
            Att.EnrollmentID = Enr.EnrollmentID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Att because Enr exists.'
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


CREATE TRIGGER tU_Att ON Att FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Att */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insAttID int
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Enr  Att on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00017630", PARENT_OWNER="", PARENT_TABLE="Enr"
    CHILD_OWNER="", CHILD_TABLE="Att"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Attendance_Enrollments", FK_COLUMNS="EnrollmentID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(EnrollmentID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Enr
        WHERE
          /* %JoinFKPK(inserted,Enr) */
          inserted.EnrollmentID = Enr.EnrollmentID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Att because Enr does not exist.'
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




CREATE TRIGGER tD_Crs ON Crs FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Crs */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Crs  Sec on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00021c5a", PARENT_OWNER="", PARENT_TABLE="Crs"
    CHILD_OWNER="", CHILD_TABLE="Sec"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Courses", FK_COLUMNS="CourseID" */
    IF EXISTS (
      SELECT * FROM deleted,Sec
      WHERE
        /*  %JoinFKPK(Sec,deleted," = "," AND") */
        Sec.CourseID = deleted.CourseID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Crs because Sec exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Dept  Crs on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Dept"
    CHILD_OWNER="", CHILD_TABLE="Crs"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Courses_Departments", FK_COLUMNS="DepartmentID" */
    IF EXISTS (SELECT * FROM deleted,Dept
      WHERE
        /* %JoinFKPK(deleted,Dept," = "," AND") */
        deleted.DepartmentID = Dept.DepartmentID AND
        NOT EXISTS (
          SELECT * FROM Crs
          WHERE
            /* %JoinFKPK(Crs,Dept," = "," AND") */
            Crs.DepartmentID = Dept.DepartmentID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Crs because Dept exists.'
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


CREATE TRIGGER tU_Crs ON Crs FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Crs */
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
  /* Crs  Sec on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0002605e", PARENT_OWNER="", PARENT_TABLE="Crs"
    CHILD_OWNER="", CHILD_TABLE="Sec"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Courses", FK_COLUMNS="CourseID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(CourseID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Sec
      WHERE
        /*  %JoinFKPK(Sec,deleted," = "," AND") */
        Sec.CourseID = deleted.CourseID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Crs because Sec exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Dept  Crs on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Dept"
    CHILD_OWNER="", CHILD_TABLE="Crs"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Courses_Departments", FK_COLUMNS="DepartmentID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(DepartmentID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Dept
        WHERE
          /* %JoinFKPK(inserted,Dept) */
          inserted.DepartmentID = Dept.DepartmentID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Crs because Dept does not exist.'
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




CREATE TRIGGER tD_Dept ON Dept FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Dept */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Dept  Prog on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0002d77d", PARENT_OWNER="", PARENT_TABLE="Dept"
    CHILD_OWNER="", CHILD_TABLE="Prog"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Programs_Departments", FK_COLUMNS="DepartmentID" */
    IF EXISTS (
      SELECT * FROM deleted,Prog
      WHERE
        /*  %JoinFKPK(Prog,deleted," = "," AND") */
        Prog.DepartmentID = deleted.DepartmentID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Dept because Prog exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Dept  Inst on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Dept"
    CHILD_OWNER="", CHILD_TABLE="Inst"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Instructors_Departments", FK_COLUMNS="DepartmentID" */
    IF EXISTS (
      SELECT * FROM deleted,Inst
      WHERE
        /*  %JoinFKPK(Inst,deleted," = "," AND") */
        Inst.DepartmentID = deleted.DepartmentID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Dept because Inst exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Dept  Crs on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Dept"
    CHILD_OWNER="", CHILD_TABLE="Crs"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Courses_Departments", FK_COLUMNS="DepartmentID" */
    IF EXISTS (
      SELECT * FROM deleted,Crs
      WHERE
        /*  %JoinFKPK(Crs,deleted," = "," AND") */
        Crs.DepartmentID = deleted.DepartmentID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Dept because Crs exists.'
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


CREATE TRIGGER tU_Dept ON Dept FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Dept */
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
  /* Dept  Prog on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0003207f", PARENT_OWNER="", PARENT_TABLE="Dept"
    CHILD_OWNER="", CHILD_TABLE="Prog"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Programs_Departments", FK_COLUMNS="DepartmentID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(DepartmentID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Prog
      WHERE
        /*  %JoinFKPK(Prog,deleted," = "," AND") */
        Prog.DepartmentID = deleted.DepartmentID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Dept because Prog exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Dept  Inst on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Dept"
    CHILD_OWNER="", CHILD_TABLE="Inst"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Instructors_Departments", FK_COLUMNS="DepartmentID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(DepartmentID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Inst
      WHERE
        /*  %JoinFKPK(Inst,deleted," = "," AND") */
        Inst.DepartmentID = deleted.DepartmentID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Dept because Inst exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Dept  Crs on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Dept"
    CHILD_OWNER="", CHILD_TABLE="Crs"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Courses_Departments", FK_COLUMNS="DepartmentID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(DepartmentID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Crs
      WHERE
        /*  %JoinFKPK(Crs,deleted," = "," AND") */
        Crs.DepartmentID = deleted.DepartmentID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Dept because Crs exists.'
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




CREATE TRIGGER tD_Enr ON Enr FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Enr */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Enr  Att on parent delete cascade */
    /* ERWIN_RELATION:CHECKSUM="0002f242", PARENT_OWNER="", PARENT_TABLE="Enr"
    CHILD_OWNER="", CHILD_TABLE="Att"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Attendance_Enrollments", FK_COLUMNS="EnrollmentID" */
    DELETE Att
      FROM Att,deleted
      WHERE
        /*  %JoinFKPK(Att,deleted," = "," AND") */
        Att.EnrollmentID = deleted.EnrollmentID

    /* erwin Builtin Trigger */
    /* Sec  Enr on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Sec"
    CHILD_OWNER="", CHILD_TABLE="Enr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Enroll_Sections", FK_COLUMNS="SectionID" */
    IF EXISTS (SELECT * FROM deleted,Sec
      WHERE
        /* %JoinFKPK(deleted,Sec," = "," AND") */
        deleted.SectionID = Sec.SectionID AND
        NOT EXISTS (
          SELECT * FROM Enr
          WHERE
            /* %JoinFKPK(Enr,Sec," = "," AND") */
            Enr.SectionID = Sec.SectionID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Enr because Sec exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Stu  Enr on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Stu"
    CHILD_OWNER="", CHILD_TABLE="Enr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Enroll_Students", FK_COLUMNS="StudentID" */
    IF EXISTS (SELECT * FROM deleted,Stu
      WHERE
        /* %JoinFKPK(deleted,Stu," = "," AND") */
        deleted.StudentID = Stu.StudentID AND
        NOT EXISTS (
          SELECT * FROM Enr
          WHERE
            /* %JoinFKPK(Enr,Stu," = "," AND") */
            Enr.StudentID = Stu.StudentID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Enr because Stu exists.'
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


CREATE TRIGGER tU_Enr ON Enr FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Enr */
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
  /* Enr  Att on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0003aa1e", PARENT_OWNER="", PARENT_TABLE="Enr"
    CHILD_OWNER="", CHILD_TABLE="Att"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Attendance_Enrollments", FK_COLUMNS="EnrollmentID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(EnrollmentID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Att
      WHERE
        /*  %JoinFKPK(Att,deleted," = "," AND") */
        Att.EnrollmentID = deleted.EnrollmentID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Enr because Att exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Sec  Enr on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Sec"
    CHILD_OWNER="", CHILD_TABLE="Enr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Enroll_Sections", FK_COLUMNS="SectionID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(SectionID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Sec
        WHERE
          /* %JoinFKPK(inserted,Sec) */
          inserted.SectionID = Sec.SectionID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Enr because Sec does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Stu  Enr on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Stu"
    CHILD_OWNER="", CHILD_TABLE="Enr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Enroll_Students", FK_COLUMNS="StudentID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(StudentID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Stu
        WHERE
          /* %JoinFKPK(inserted,Stu) */
          inserted.StudentID = Stu.StudentID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Enr because Stu does not exist.'
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




CREATE TRIGGER tD_Inst ON Inst FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Inst */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Inst  Sec on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00022571", PARENT_OWNER="", PARENT_TABLE="Inst"
    CHILD_OWNER="", CHILD_TABLE="Sec"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Instructors", FK_COLUMNS="InstructorID" */
    IF EXISTS (
      SELECT * FROM deleted,Sec
      WHERE
        /*  %JoinFKPK(Sec,deleted," = "," AND") */
        Sec.InstructorID = deleted.InstructorID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Inst because Sec exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Dept  Inst on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Dept"
    CHILD_OWNER="", CHILD_TABLE="Inst"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Instructors_Departments", FK_COLUMNS="DepartmentID" */
    IF EXISTS (SELECT * FROM deleted,Dept
      WHERE
        /* %JoinFKPK(deleted,Dept," = "," AND") */
        deleted.DepartmentID = Dept.DepartmentID AND
        NOT EXISTS (
          SELECT * FROM Inst
          WHERE
            /* %JoinFKPK(Inst,Dept," = "," AND") */
            Inst.DepartmentID = Dept.DepartmentID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Inst because Dept exists.'
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


CREATE TRIGGER tU_Inst ON Inst FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Inst */
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
  /* Inst  Sec on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00026f76", PARENT_OWNER="", PARENT_TABLE="Inst"
    CHILD_OWNER="", CHILD_TABLE="Sec"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Instructors", FK_COLUMNS="InstructorID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(InstructorID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Sec
      WHERE
        /*  %JoinFKPK(Sec,deleted," = "," AND") */
        Sec.InstructorID = deleted.InstructorID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Inst because Sec exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Dept  Inst on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Dept"
    CHILD_OWNER="", CHILD_TABLE="Inst"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Instructors_Departments", FK_COLUMNS="DepartmentID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(DepartmentID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Dept
        WHERE
          /* %JoinFKPK(inserted,Dept) */
          inserted.DepartmentID = Dept.DepartmentID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Inst because Dept does not exist.'
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




CREATE TRIGGER tD_Prog ON Prog FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Prog */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Prog  Stu on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0002120c", PARENT_OWNER="", PARENT_TABLE="Prog"
    CHILD_OWNER="", CHILD_TABLE="Stu"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Students_Programs", FK_COLUMNS="ProgramID" */
    IF EXISTS (
      SELECT * FROM deleted,Stu
      WHERE
        /*  %JoinFKPK(Stu,deleted," = "," AND") */
        Stu.ProgramID = deleted.ProgramID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Prog because Stu exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Dept  Prog on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Dept"
    CHILD_OWNER="", CHILD_TABLE="Prog"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Programs_Departments", FK_COLUMNS="DepartmentID" */
    IF EXISTS (SELECT * FROM deleted,Dept
      WHERE
        /* %JoinFKPK(deleted,Dept," = "," AND") */
        deleted.DepartmentID = Dept.DepartmentID AND
        NOT EXISTS (
          SELECT * FROM Prog
          WHERE
            /* %JoinFKPK(Prog,Dept," = "," AND") */
            Prog.DepartmentID = Dept.DepartmentID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Prog because Dept exists.'
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


CREATE TRIGGER tU_Prog ON Prog FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Prog */
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
  /* Prog  Stu on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="000257fa", PARENT_OWNER="", PARENT_TABLE="Prog"
    CHILD_OWNER="", CHILD_TABLE="Stu"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Students_Programs", FK_COLUMNS="ProgramID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ProgramID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Stu
      WHERE
        /*  %JoinFKPK(Stu,deleted," = "," AND") */
        Stu.ProgramID = deleted.ProgramID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Prog because Stu exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Dept  Prog on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Dept"
    CHILD_OWNER="", CHILD_TABLE="Prog"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Programs_Departments", FK_COLUMNS="DepartmentID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(DepartmentID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Dept
        WHERE
          /* %JoinFKPK(inserted,Dept) */
          inserted.DepartmentID = Dept.DepartmentID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Prog because Dept does not exist.'
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




CREATE TRIGGER tD_Room ON Room FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Room */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Room  Sec on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00010a86", PARENT_OWNER="", PARENT_TABLE="Room"
    CHILD_OWNER="", CHILD_TABLE="Sec"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Classrooms", FK_COLUMNS="ClassroomID" */
    IF EXISTS (
      SELECT * FROM deleted,Sec
      WHERE
        /*  %JoinFKPK(Sec,deleted," = "," AND") */
        Sec.ClassroomID = deleted.ClassroomID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Room because Sec exists.'
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


CREATE TRIGGER tU_Room ON Room FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Room */
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
  /* Room  Sec on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00012330", PARENT_OWNER="", PARENT_TABLE="Room"
    CHILD_OWNER="", CHILD_TABLE="Sec"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Classrooms", FK_COLUMNS="ClassroomID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ClassroomID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Sec
      WHERE
        /*  %JoinFKPK(Sec,deleted," = "," AND") */
        Sec.ClassroomID = deleted.ClassroomID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Room because Sec exists.'
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




CREATE TRIGGER tD_Sec ON Sec FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Sec */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Sec  Enr on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00054932", PARENT_OWNER="", PARENT_TABLE="Sec"
    CHILD_OWNER="", CHILD_TABLE="Enr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Enroll_Sections", FK_COLUMNS="SectionID" */
    IF EXISTS (
      SELECT * FROM deleted,Enr
      WHERE
        /*  %JoinFKPK(Enr,deleted," = "," AND") */
        Enr.SectionID = deleted.SectionID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Sec because Enr exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Room  Sec on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Room"
    CHILD_OWNER="", CHILD_TABLE="Sec"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Classrooms", FK_COLUMNS="ClassroomID" */
    IF EXISTS (SELECT * FROM deleted,Room
      WHERE
        /* %JoinFKPK(deleted,Room," = "," AND") */
        deleted.ClassroomID = Room.ClassroomID AND
        NOT EXISTS (
          SELECT * FROM Sec
          WHERE
            /* %JoinFKPK(Sec,Room," = "," AND") */
            Sec.ClassroomID = Room.ClassroomID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sec because Room exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Inst  Sec on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Inst"
    CHILD_OWNER="", CHILD_TABLE="Sec"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Instructors", FK_COLUMNS="InstructorID" */
    IF EXISTS (SELECT * FROM deleted,Inst
      WHERE
        /* %JoinFKPK(deleted,Inst," = "," AND") */
        deleted.InstructorID = Inst.InstructorID AND
        NOT EXISTS (
          SELECT * FROM Sec
          WHERE
            /* %JoinFKPK(Sec,Inst," = "," AND") */
            Sec.InstructorID = Inst.InstructorID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sec because Inst exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Sem  Sec on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Sem"
    CHILD_OWNER="", CHILD_TABLE="Sec"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Semesters", FK_COLUMNS="SemesterID" */
    IF EXISTS (SELECT * FROM deleted,Sem
      WHERE
        /* %JoinFKPK(deleted,Sem," = "," AND") */
        deleted.SemesterID = Sem.SemesterID AND
        NOT EXISTS (
          SELECT * FROM Sec
          WHERE
            /* %JoinFKPK(Sec,Sem," = "," AND") */
            Sec.SemesterID = Sem.SemesterID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sec because Sem exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Crs  Sec on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Crs"
    CHILD_OWNER="", CHILD_TABLE="Sec"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Courses", FK_COLUMNS="CourseID" */
    IF EXISTS (SELECT * FROM deleted,Crs
      WHERE
        /* %JoinFKPK(deleted,Crs," = "," AND") */
        deleted.CourseID = Crs.CourseID AND
        NOT EXISTS (
          SELECT * FROM Sec
          WHERE
            /* %JoinFKPK(Sec,Crs," = "," AND") */
            Sec.CourseID = Crs.CourseID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sec because Crs exists.'
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


CREATE TRIGGER tU_Sec ON Sec FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Sec */
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
  /* Sec  Enr on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0006388d", PARENT_OWNER="", PARENT_TABLE="Sec"
    CHILD_OWNER="", CHILD_TABLE="Enr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Enroll_Sections", FK_COLUMNS="SectionID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(SectionID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Enr
      WHERE
        /*  %JoinFKPK(Enr,deleted," = "," AND") */
        Enr.SectionID = deleted.SectionID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Sec because Enr exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Room  Sec on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Room"
    CHILD_OWNER="", CHILD_TABLE="Sec"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Classrooms", FK_COLUMNS="ClassroomID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ClassroomID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Room
        WHERE
          /* %JoinFKPK(inserted,Room) */
          inserted.ClassroomID = Room.ClassroomID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.ClassroomID IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sec because Room does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Inst  Sec on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Inst"
    CHILD_OWNER="", CHILD_TABLE="Sec"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Instructors", FK_COLUMNS="InstructorID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(InstructorID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Inst
        WHERE
          /* %JoinFKPK(inserted,Inst) */
          inserted.InstructorID = Inst.InstructorID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sec because Inst does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Sem  Sec on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Sem"
    CHILD_OWNER="", CHILD_TABLE="Sec"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Semesters", FK_COLUMNS="SemesterID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(SemesterID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Sem
        WHERE
          /* %JoinFKPK(inserted,Sem) */
          inserted.SemesterID = Sem.SemesterID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sec because Sem does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Crs  Sec on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Crs"
    CHILD_OWNER="", CHILD_TABLE="Sec"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Courses", FK_COLUMNS="CourseID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(CourseID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Crs
        WHERE
          /* %JoinFKPK(inserted,Crs) */
          inserted.CourseID = Crs.CourseID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sec because Crs does not exist.'
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




CREATE TRIGGER tD_Sem ON Sem FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Sem */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Sem  Sec on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00010843", PARENT_OWNER="", PARENT_TABLE="Sem"
    CHILD_OWNER="", CHILD_TABLE="Sec"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Semesters", FK_COLUMNS="SemesterID" */
    IF EXISTS (
      SELECT * FROM deleted,Sec
      WHERE
        /*  %JoinFKPK(Sec,deleted," = "," AND") */
        Sec.SemesterID = deleted.SemesterID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Sem because Sec exists.'
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


CREATE TRIGGER tU_Sem ON Sem FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Sem */
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
  /* Sem  Sec on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0001155c", PARENT_OWNER="", PARENT_TABLE="Sem"
    CHILD_OWNER="", CHILD_TABLE="Sec"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sections_Semesters", FK_COLUMNS="SemesterID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(SemesterID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Sec
      WHERE
        /*  %JoinFKPK(Sec,deleted," = "," AND") */
        Sec.SemesterID = deleted.SemesterID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Sem because Sec exists.'
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




CREATE TRIGGER tD_Stu ON Stu FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Stu */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Stu  Enr on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00021272", PARENT_OWNER="", PARENT_TABLE="Stu"
    CHILD_OWNER="", CHILD_TABLE="Enr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Enroll_Students", FK_COLUMNS="StudentID" */
    IF EXISTS (
      SELECT * FROM deleted,Enr
      WHERE
        /*  %JoinFKPK(Enr,deleted," = "," AND") */
        Enr.StudentID = deleted.StudentID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Stu because Enr exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Prog  Stu on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Prog"
    CHILD_OWNER="", CHILD_TABLE="Stu"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Students_Programs", FK_COLUMNS="ProgramID" */
    IF EXISTS (SELECT * FROM deleted,Prog
      WHERE
        /* %JoinFKPK(deleted,Prog," = "," AND") */
        deleted.ProgramID = Prog.ProgramID AND
        NOT EXISTS (
          SELECT * FROM Stu
          WHERE
            /* %JoinFKPK(Stu,Prog," = "," AND") */
            Stu.ProgramID = Prog.ProgramID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Stu because Prog exists.'
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


CREATE TRIGGER tU_Stu ON Stu FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Stu */
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
  /* Stu  Enr on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00025a05", PARENT_OWNER="", PARENT_TABLE="Stu"
    CHILD_OWNER="", CHILD_TABLE="Enr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Enroll_Students", FK_COLUMNS="StudentID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(StudentID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Enr
      WHERE
        /*  %JoinFKPK(Enr,deleted," = "," AND") */
        Enr.StudentID = deleted.StudentID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Stu because Enr exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Prog  Stu on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Prog"
    CHILD_OWNER="", CHILD_TABLE="Stu"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Students_Programs", FK_COLUMNS="ProgramID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ProgramID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Prog
        WHERE
          /* %JoinFKPK(inserted,Prog) */
          inserted.ProgramID = Prog.ProgramID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Stu because Prog does not exist.'
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


