/***********************************
***** Optional Relational Data *****
***********************************/
/*
INSERT INTO CoursePreReq (ParentCourseID, CourseID)
VALUES  /* (,,), */

INSERT INTO DegreeCategory (DegreeID, CategoryID)
VALUES  /* (,,), */
*/
/********************************
***** Misc Query Statements *****
********************************/

/****** Top 1000 Rows from MajorCategory Table ******/
SELECT TOP 1000 [ID],
				[CreditsRequired],
				[ParentMajorCategoryID],
				[MajorID],
				[CategoryID]
  FROM [MajorAdviser].[dbo].[MajorCategory]
  
  /* Category Title's */
  SELECT [Title] FROM Category;

  /* MajorCategory ID's */
  SELECT MajorCategory.ID, Category.Title AS [Category Title], CreditsRequired FROM MajorCategory, Major, Category
  WHERE MajorCategory.MajorID = Major.ID
		AND MajorCategory.CategoryID = Category.ID
		AND Major.Title = 'Computer Programming and Analysis (Software Engineering Technology)'
  GROUP BY MajorCategory.ID, Major.Title, Category.Title, CreditsRequired
  ORDER BY CreditsRequired DESC

  /* Query MajorCourses grouped by MajorCategory */
  SELECT Category.Title AS [Category Title], Course.Title AS [Course Title] /*, CreditsRequired*/ FROM MajorCategoryCourse, MajorCategory, Major, Category, Course
  WHERE MajorCategory.MajorID = Major.ID
		AND MajorCategory.CategoryID = Category.ID
		AND Major.Title = 'Computer Engineering Technology'
		AND MajorCategoryCourse.MajorCategoryID = MajorCategory.ID
		AND MajorCategoryCourse.CourseID = Course.ID
  GROUP BY Category.Title, Course.Title/*, CreditsRequired*/

  /* Query ALL Courses */
  SELECT ID, Code, Title FROM Course

  /* Query Course Information filtered by Course.Title */
  SELECT ID, Code, Title, [Description] FROM Course
  WHERE Title LIKE 'Web Design%'
  /*WHERE Code LIKE 'EET%'*/

  /* Query ALL items from MajorCategory Table */
  SELECT * FROM MajorCategory

  /* Query ONLY AS Degree Computer Science Degrees from Major Table */
  SELECT Title FROM Major
  WHERE Code LIKE '2%'
	/* Filter by Course.Title that begin w/ the letter... */
	AND Title LIKE 'C%'
	 OR Title LIKE 'E%'

  /* Query Category Title & ID for specified Major.Title */
  SELECT Major.Title AS [Major], MajorCategory.ID AS [MajorCategory ID], Category.Title AS [Category]
  FROM Major, Category, MajorCategory
  WHERE MajorCategory.MajorID = Major.ID
	AND MajorCategory.CategoryID = Category.ID
	AND Major.Title = 'Computer Programming and Analysis (Software Engineering Technology)'

  /* Query Student Courses completed applied to Major identified by Course title */
  SELECT Category.Title AS [Category Title], Course.Title AS [Course Title], CreditHours
  FROM Student, Course, Category, Major, StudentCourse, MajorCategory, MajorCategoryCourse
  WHERE MajorCategoryCourse.MajorCategoryID = MajorCategory.ID
		AND MajorCategoryCourse.CourseID = Course.ID
		AND MajorCategory.MajorID = Major.ID
		AND MajorCategory.CategoryID = Category.ID
		AND StudentCourse.StudentID = Student.ID
		AND StudentCourse.CourseID = Course.ID
		AND Student.Name = 'John Doe'
		AND Major.Title = 'Computer Information Technology'

  /* Query Student Courses completed applied to Major grouped by Category */
  SELECT Category.Title AS [Category Title], /*Course.Title AS [Course Title],*/ SUM(CreditHours) AS [Total Credit Hours]
  FROM Student, Course, Category, Major, StudentCourse, MajorCategory, MajorCategoryCourse
  WHERE MajorCategoryCourse.MajorCategoryID = MajorCategory.ID
		AND MajorCategoryCourse.CourseID = Course.ID
		AND MajorCategory.MajorID = Major.ID
		AND MajorCategory.CategoryID = Category.ID
		AND StudentCourse.StudentID = Student.ID
		AND StudentCourse.CourseID = Course.ID
		AND Student.Name = 'John Doe'
		/*AND Major.Title = 'Computer Engineering Technology'*/
		AND Major.Title = 'Computer Information Technology'
		/*AND Major.Title = 'Computer Programming and Analysis (Software Engineering Technology)'*/
  GROUP BY Category.Title /*Course.Title, CreditHours */
  ORDER BY SUM(CreditHours) DESC

  /* Query Student Courses completed filtered by Student Name */
  SELECT Course.Code AS [Course Code], Course.Title AS [Course Title], CreditHours
  FROM Student, Course, Category, Major, StudentCourse
  WHERE StudentCourse.StudentID = Student.ID
		AND StudentCourse.CourseID = Course.ID
		AND Student.Name = 'John Doe'
  GROUP BY Course.Code, Course.Title, CreditHours
  
    /* Query Courses filtered by Major */
  SELECT Category.Title AS [Category], Course.Title AS [Course] 
  FROM Course, Category, Major, MajorCategory, MajorCategoryCourse
  WHERE MajorCategoryCourse.MajorCategoryID = MajorCategory.ID
    AND MajorCategoryCourse.CourseID = Course.ID
	AND MajorCategory.CategoryID = Category.ID
	AND MajorCategory.MajorID = Major.ID
	AND Major.Title = 'Computer Engineering Technology'
  ORDER BY Category.Title, Course.Title
  
  /*-------------------------------------------------------------------------------------*/
 
    /* Degree Info */
  SELECT ID, Code, Title FROM Degree
  ORDER BY ID

    /* Category Title */
  SELECT ID, Title FROM Category
  ORDER BY ID

    /* Computer Science Major's filtered by AS Certification */
  SELECT ID, Code, Title FROM Major
  WHERE Code LIKE '0%'
	AND Code NOT LIKE '0100'
  ORDER BY ID

    /* Course Info */
  SELECT Code, Title FROM Course
  ORDER BY ID

    /* Query Major.Title & MajorCategory.ID for specified Degree.Title */
  SELECT /*Degree.Title AS [Degree],*/ Major.Title AS [Major], MajorCategory.ID AS [MajorCategory ID], Category.Title AS [Category]
  FROM Major, Category, MajorCategory, Degree
  WHERE MajorCategory.MajorID = Major.ID
	AND MajorCategory.CategoryID = Category.ID
	AND Major.DegreeID = Degree.ID
	AND Degree.Code = 'ASC'
	
	  /* Query Courses filtered by Major */
  SELECT Major.Title AS Major, /*Course.Code AS [Code], Course.Title AS [Course],*/ SUM(CreditHours) AS [Credit Hours]
  FROM Course, Category, Major, MajorCategory, MajorCategoryCourse, Degree
  WHERE MajorCategoryCourse.MajorCategoryID = MajorCategory.ID
    AND MajorCategoryCourse.CourseID = Course.ID
	AND MajorCategory.CategoryID = Category.ID
	AND MajorCategory.MajorID = Major.ID
	AND Major.DegreeID = Degree.ID
	AND Degree.Code = 'ASC'
  GROUP BY Major.Title
 /* ORDER BY Category.Title, Course.Title */