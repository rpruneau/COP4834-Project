USE [aspnet-MajorAdviser]
/* MajorAdviser Database Application */


/***************************************
***** Independent Table Structures *****
***************************************/
CREATE TABLE Student(
	ID int NOT NULL PRIMARY KEY IDENTITY (1,1),
	Name nvarchar(255) NOT NULL,
	Email nvarchar(255) NOT NULL,
	[Password] nvarchar(255) NOT NULL)

CREATE TABLE Course(
	ID int NOT NULL PRIMARY KEY IDENTITY (1,1),
	Code nvarchar(10) NOT NULL UNIQUE,
	Title nvarchar(255) NOT NULL,
	[Description] nvarchar(MAX) NULL,
	CreditHours decimal(5,2) NOT NULL,
	ConcReqID int NULL)

CREATE TABLE Degree(
	ID int NOT NULL PRIMARY KEY IDENTITY (1,1),
	Code nvarchar(10) NOT NULL UNIQUE,
	Title nvarchar(255) NOT NULL)

CREATE TABLE Category(
	ID int NOT NULL PRIMARY KEY IDENTITY (1,1),
	Title nvarchar(255) UNIQUE NOT NULL)
	
/***************************************************************
***** Dependent Table Structures (Join/Intersection Tables)*****
***************************************************************/
CREATE TABLE Major(
	ID int NOT NULL PRIMARY KEY IDENTITY (1,1),
	Code nvarchar(10) NOT NULL UNIQUE,
	Title nvarchar(255) NOT NULL,
	DegreeID int FOREIGN KEY REFERENCES Degree(ID))

CREATE TABLE StudentCourse(
	ID int NOT NULL PRIMARY KEY IDENTITY (1,1),
	StudentID int FOREIGN KEY REFERENCES Student(ID),
	CourseID int FOREIGN KEY REFERENCES Course(ID))

CREATE TABLE MajorCategory(
	ID int NOT NULL PRIMARY KEY IDENTITY (1,1),
	CreditsRequired decimal(5,0) NOT NULL,
	ParentMajorCategoryID int NULL,
	MajorID int FOREIGN KEY REFERENCES Major(ID),
	CategoryID int FOREIGN KEY REFERENCES Category(ID))

CREATE TABLE MajorCategoryCourse(
	ID int NOT NULL PRIMARY KEY IDENTITY (1,1),
	MajorCategoryID int FOREIGN KEY REFERENCES MajorCategory(ID),
	CourseID int FOREIGN KEY REFERENCES Course(ID))
	

CREATE TABLE CoursePreReq(
	ID int NOT NULL PRIMARY KEY IDENTITY (1,1),
	ParentCourseID int FOREIGN KEY REFERENCES Course(ID),
	CourseID int FOREIGN KEY REFERENCES Course(ID))
/*	
CREATE TABLE DegreeCategory(
	ID int NOT NULL PRIMARY KEY IDENTITY (1,1),
	DegreeID int FOREIGN KEY REFERENCES Degree(ID),
	CategoryID int FOREIGN KEY REFERENCES Category(ID))	
*/
-----------------------------------------------------------------------------------------------------
/* Populate Tables w/ Data */
-----------------------------------------------------------------------------------------------------
/*********************************
***** Independent Table Data *****
*********************************/
INSERT INTO Student (Name, Email, [Password])
VALUES ('John Doe','JohnDoe@aol.com','Password'),
		('Jane Doe','JaneDoe@aol.com','Password');

INSERT INTO Course (Code, Title, [Description], CreditHours, ConcReqID)
VALUES
		/* Communications Core */
		('ENC1101','Introduction to Composition','This course is designed to develop skills in critical thinking, the writing process, and for composing in different rhetorical situations. This course contributes to satisfying the Gordon Rule (State Rule 6A-10.030) writing requirement. Students meeting predetermined criteria are required to take SLS1101 concurrently with ENC1101. (Prerequisite: Appropriate placement scores, successful completion of college prep course or qualified developmental exemption.)',3.00,NULL),
		('ENC1102','Writing with Research','This course is designed to continue developing skills for critical thinking, the writing process, and navigating rhetorical situations with the addition of inquiry based on research, synthesis and argument. This course contributes to satisfying the Gordon Rule (State Rule 6A-10.030) writing requirement.',3.00,NULL),
		('SPC2608','Oral Communications/Research/Presentation Skills','Basic principles of speech communication, including practice with various types and methods of oral expression.',3.00,NULL),
		('RTV2300','Broadcast Research/Newswriting/Presentation Skills','Basic instruction and practice in news gathering, writing and announcing for radio and TV. Students will create a video portfolio of live performances. This course contributes to satisfying the Gordon Rule (State Rule 6A-10.030) writing requirement.',3.00,NULL),

		/* Mathematics Core */
		('MAC1105','College Algebra','Topics include: Polynomial and rational equations and inequalities, graphs of functions, rate of change, transformations, extreme values, modeling, combining functions, one-to-one and inverse functions, exponential functions, logarithmic functions, laws of logarithms, exponential and logarithmic equations, modeling, systems of equations, linear systems in three variables, nonlinear systems of equations, and linear and nonlinear systems of inequalities. (Prerequisite: Appropriate placement scores, successful completion of college prep course or qualified developmental exemption or passed MAT 1033 with grade "C" or better or permission of chairperson).',3.00,NULL),
		('MAC1114','College Trigonometry','Topics include: The unit circle, trigonometric functions (definitions, graphs and inverses), right triangles, oblique triangles, trigonometric identities, trigonometric equations, the trigonometric form of complex numbers, two-dimensional vectors, polar coordinates, and parametric equations. A scientific calculator is required. (Prerequisite: Appropriate placement scores, successful completion of college prep course or qualified developmental exemption or passed MAC 1105 with grade "C" or better or permission of chairperson).',3.00,NULL),
		('MAC1140','Pre-Calculus Algebra','Topics include: Graphing, solving equations and applications involving exponential and logarithmic functions; Systems of Equations, linear and nonlinear, two-variable and multivariable, and partial fractions; Matrices, inverses, determinants and Cramers Rule; Sequences and Series, arithmetic sequences and partial sums, geometric sequences and series, Mathematical Induction, and the Binomial Theorem; Analytic Geometry, parabolas, ellipses, hyperbolas, and transformations of conics; Introduction to Limits, the two-sided limit, the derivative, and limits to infinity. (Prerequisite: Appropriate placement scores, successful completion of college prep course or qualified developmental exemption or passed MAC 1105 with grade "C" or better or permission of chairperson).',3.00,NULL),
		('MAC2233','Calculus for Business and Nonphysical Sciences I','This course is designed for students who plan to major in Business or the Social Sciences. Topics include: Limits, continuity, differentiation and integration of algebraic, exponential and logarithmic functions with emphasis placed on applications in business, economics, and social sciences. A scientific calculator is required. (Prerequisite: Appropriate placement scores, successful completion of college prep course or qualified developmental exemption or passed MAC 1140 with grade "C" or better or permission of chairperson).',3.00,NULL),
		('MAC2311','Calculus I','Topics include: Functions and graphs, mathematical models, limits, continuity, slope of a curve, derivatives of algebraic and transcendental functions, techniques of differentiation, applications of derivatives, differentials, optimization, plane areas, anti-derivatives, definite integrals, and Fundamental Theorem of Calculus. A graphing calculator is required. (Prerequisite: Appropriate placement scores, successful completion of college prep course or qualified developmental exemption or passed MAC 1140 and MAC 1114 with grade "C" or better or permission of chairperson).',3.00,10),
		('MAC2311L','Calculus I Lab','Lab component for; Topics include: Functions and graphs, mathematical models, limits, continuity, slope of a curve, derivatives of algebraic and transcendental functions, techniques of differentiation, applications of derivatives, differentials, optimization, plane areas, anti-derivatives, definite integrals, and Fundamental Theorem of Calculus. A graphing calculator is required. (Prerequisite: Appropriate placement scores, successful completion of college prep course or qualified developmental exemption or passed MAC 1140 and MAC 1114 with grade "C" or better or permission of chairperson).',1.00,9),
		('MAC2312','Calculus II','Topics include: Techniques of integration, applications of integrations, differentiation and integration in polar form, sequences and series. (Prerequisite: Appropriate placement scores, successful completion of college prep course or qualified developmental exemption or passed MAC 2311/2311L with grade "C" or better or permission of chairperson).',3.00,12),
		('MAC2312L','Calculus II Lab','Lab component for; Topics include: Techniques of integration, applications of integrations, differentiation and integration in polar form, sequences and series. (Prerequisite: Appropriate placement scores, successful completion of college prep course or qualified developmental exemption or passed MAC 2311/2311L with grade "C" or better or permission of chairperson).',1.00,11),
		('MAC2313','Calculus III','Topics include: Vectors analysis and applications, equations of lines and planes in space, vector valued functions, partial derivatives, and minimizing/maximizing functions of several variables, Lagrange Multipliers, directional derivatives, gradient, iterated, multiple, surface and line integrals, and Greens Theorem. (Prerequisite: Appropriate placement scores, successful completion of college prep course or qualified developmental exemption or passed MAC 2312/2312L with grade "C" or better or permission of chairperson).',3.00,14),
		('MAC2313L','Calculus III Lab','Lab component for; Topics include: Vectors analysis and applications, equations of lines and planes in space, vector valued functions, partial derivatives, and minimizing/maximizing functions of several variables, Lagrange Multipliers, directional derivatives, gradient, iterated, multiple, surface and line integrals, and Greens Theorem. (Prerequisite: Appropriate placement scores, successful completion of college prep course or qualified developmental exemption or passed MAC 2312/2312L with grade "C" or better or permission of chairperson).',1.00,13),
		('MAP2302','Differential Equations','Topics include: First order ordinary differential equations, theory of linear ordinary differential equations solutions of linear and non-linear equations including variation of parameters, undetermined coefficients and Laplace transformations, matrix methods along with applications such as Newtons Law of Cooling, mixture problems, springs and free fall. (Prerequisite: Appropriate placement scores, successful completion of college prep course or qualified developmental exemption or passed MAC 2312/2312L with grade "C" or better or permission of chairperson or concurrent requisite MAP 2302/2302L).',2.00,16),
		('MAP2302L','Differential Equations Lab','Lab component for; Topics include: First order ordinary differential equations, theory of linear ordinary differential equations solutions of linear and non-linear equations including variation of parameters, undetermined coefficients and Laplace transformations, matrix methods along with applications such as Newtons Law of Cooling, mixture problems, springs and free fall. (Prerequisite: Appropriate placement scores, successful completion of college prep course or qualified developmental exemption or passed MAC 2312/2312L with grade "C" or better or permission of chairperson or concurrent requisite MAP 2302/2302L).',1.00,15),
		('MGF2106','Survey in Mathematics','This course is designed to motivate students and to illustrate the relevance of mathematics in everyday life. The objective of this course is not to focus on algebraic manipulation, but rather on the understanding and interpretation of real world applications. Topics include a review of the basic operations of real numbers, sets, linear functions, systems of linear equations, linear programming, introduction to probability and statistics, interest and annuities, and geometry. (Prerequisite: Appropriate placement scores, successful completion of college prep course or qualified developmental exemption or passed MAT 0028/0028L with grade "B" or better or permission of chairperson.)',3.00,NULL),
		('MGF2107','Mathematics for Liberal Arts','Topics include: Consumer mathematics, mathematical modeling, and geometry in art, graph theory, voting, apportionment techniques and history of mathematics. Applications to real-world situations are heavily emphasized. (Prerequisite: Placement through Daytona State College placement test or MAT0028 with grade "B" or better or permission of chairperson.)',3.00,NULL),
		('STA2023','Elementary Statistics','Topics include: A survey of descriptive statistics and graphs, probability, random variables, confidence intervals, hypothesis testing, sampling, types of distributions, correlation and regression, and statistical applications.',3.00,NULL),

		/* Health & Wellness Core */
		('HLP1081','Fitness Assessment and Improvement','This course evaluates the students level of fitness, then develops a program of improvement through daily exercise and instruction in the areas of nutrition, stress management and basic training techniques.',3.00,NULL),
		('HSC2400','First Aid, Responding to Emergencies','Demonstrations, practical experiences, lectures and discussions on the principles and skills essential to the individual for the care of emergencies in the home and community. Certificates in CPR and Responding to Emergencies will be issued to those individuals successfully completing the course.',3.00,NULL),
		('HUN1201','Human Nutrition','This introductory course focuses on the principles of nutrition science and how they relate to human physiology and health. Practical applications for using nutrition as part of a personal approach to wellness are emphasized.',3.00,NULL),
		('HUN1270','Sports Nutrition','Introduces human nutrition and its relationships to athletic performance, fitness and health. Presents scientifically-based sports nutrition recommendations for the active person and the trained athlete.',3.00,NULL),
		('PET2084','Personal Health and Wellness','The components of fitness are blended with the presentation and understanding of information relating to nutrition, resistance training, common illnesses, sexually transmitted diseases, stress management, health care, substance abuse and managing personal lifestyles.',3.00,NULL),
		('SLS2505','Critical Thinking','This course is designed to teach students to become critical thinkers, showing students how to apply their critical thinking skills to everyday problems and issues in school, in careers, and in their personal lives and public affairs. This course contributes to satisfying the Gordon Rule (State Rule 6A-10.030) writing requirement. (Prerequisite or corequisite: ENC 1101.)',3.00,NULL),

		/* Physical Sciences Core */
		('BOT1010','General Botany','General principles of the structural organization and function of plants emphasizing cellular structure and physiology, anatomy, genetics, growth and diversity of plants.',3.00,27),
		('BOT1010L','General Botany Lab','Lab component for; General principles of the structural organization and function of plants emphasizing cellular structure and physiology, anatomy, genetics, growth and diversity of plants.',1.00,26),
		('BSC1005','Survey of Biological Sciences (For Non-Science Majors)','A survey of topics in biology designed to meet the informational needs of the non-scientist. Coverage of topics in molecular, cellular, organismal and population biology is included. Pre or Co-requisite ENC1101 (Not intended for science, engineering or pre-professional health-related majors.)',4.00,NULL),
		('BSC1010','General Biology I (For Science Majors)','Basic principles, which apply to the nature of plant and animal cells, including metabolism, reproduction, protein synthesis and genetics. Designed for Science majors.',3.00,30),
		('BSC1010L','General Biology I (For Science Majors) Lab','Lab component for; Basic principles, which apply to the nature of plant and animal cells, including metabolism, reproduction, protein synthesis and genetics. Designed for Science majors.',1.00,29),
		('BSC1020','Human Biology','This course provides an introduction to scientific inquiry in relationship to the human body, its systems and basic functions with emphasis on homeostasis mechanisms. Not intended for science majors.',3.00,NULL),
		('BSC2930','Biological Themes in Film','An introductory course in general biology exploring the major themes of biology by analyzing their applications in science fiction films. Topics include biotechnology, evolution, conservation, and biomedical ethics. This course satisfies the General Education requirement for Biological Science. This course cannot be substituted for BSC 1010 and BSC 1011.',3.00,NULL),
		('OCB2000','Introduction to Marine Biology','An introduction to the chemical, physical, and biological components of the marine environment. Emphasis is on the study of marine organisms and their ecological roles. Specific topics include Florida coastal and intracoastal systems and issues. Several one-day field trips are scheduled in addition to the weekly laboratory sessions.',3.00,34),
		('OCB2000L','Introduction to Marine Biology Lab','Lab component for; An introduction to the chemical, physical, and biological components of the marine environment. Emphasis is on the study of marine organisms and their ecological roles. Specific topics include Florida coastal and intracoastal systems and issues. Several one-day field trips are scheduled in addition to the weekly laboratory sessions.',1.00,33),
		('BSC1085','Human Anatomy and Physiology I','Structure and function of the integumentary, skeletal, muscular and nervous systems of the human body. Course also will cover basic cytology and histology. This course is designed for students in health professions. A background in biology and chemistry strongly recommended.',3.00,36),
		('BSC1085L','Human Anatomy and Physiology I Lab','Lab component for; Structure and function of the integumentary, skeletal, muscular and nervous systems of the human body. Course also will cover basic cytology and histology. This course is designed for students in health professions. A background in biology and chemistry strongly recommended.',1.00,35),
		('BSC1086','Human Anatomy and Physiology II','Mandatory laboratory portion of BSC1086 covering the structure and function of the autonomic nervous system, digestive, urinary, respiratory, endocrine, circulatory and reproductive systems. This course is designed for students in health professions.',3.00,38),
		('BSC1086L','Human Anatomy and Physiology II Lab','Lab component for; Mandatory laboratory portion of BSC1086 covering the structure and function of the autonomic nervous system, digestive, urinary, respiratory, endocrine, circulatory and reproductive systems. This course is designed for students in health professions.',1.00,37),
		
		/* Biological Sciences Core */
		('AST1002','Astronomy','A survey of planetary, stellar and galactic astronomy; history of astronomy; and theories of the universe. Optional observing sessions may be held if the weather permits.',3.00,NULL),
		('CHM1025','Introduction to Chemistry','Survey of modern chemistry, designed particularly for those with little or no chemistry background or for those needing an overview of chemistry. May also be used as a preliminary to CHM 1045/1045L. Three-hour lecture, one-hour recitation/ laboratory (CHM1025L).',3.00,41),
		('CHM1025L','Introduction to Chemistry Lab','Lab component for; Survey of modern chemistry, designed particularly for those with little or no chemistry background or for those needing an overview of chemistry. May also be used as a preliminary to CHM 1045/1045L. Three-hour lecture, one-hour recitation/ laboratory (CHM1025L).',1.00,40),
		('CHM1045','General College Chemistry I','Fundamental laws and theories of chemistry and related laboratory experiments. Designed for students majoring in science. Three-hour lecture, three-hour laboratory. (Prerequisites or corequisites: ENC 1101 and MAC 1105 and satisfactory completion of CHM 1025/1025L or evidence of satisfactory achievement in high school chemistry.)',3.00,43),
		('CHM1045L','General College Chemistry I Lab','Lab component for; Fundamental laws and theories of chemistry and related laboratory experiments. Designed for students majoring in science. Three-hour lecture, three-hour laboratory. (Prerequisites or corequisites: ENC 1101 and MAC 1105 and satisfactory completion of CHM 1025/1025L or evidence of satisfactory achievement in high school chemistry.)',1.00,42),
		('GLY2010','Physical Geology','Detailed study of the materials comprising the earths crust and interior and the forces acting to change its surface; the origin of continents and ocean basins in light of recent geologic research.',3.00,45),
		('GLY2010L','Physical Geology Lab','Mandatory Laboratory portion of GLY2010. Detailed study of the materials comprising the earths crust and interior and the forces acting to change its surface; the origin of continents and ocean basins in light of recent geologic research.',1.00,44),
		('MET2010','Meteorology','An introduction to the fundamentals of weather and climate. Topics include temperature, humidity, clouds, precipitation, air masses, fronts, storms, air pollution and climate. Emphasis is on how these processes take place and their results.',3.00,NULL),
		('OCE1001','Introduction to Oceanography','An introduction to oceanography, including the geology, biology, chemistry, physics and hydrology of the worlds ocean basins and the coupling effects of the ocean and atmosphere.',3.00,NULL),
		('PHY1020','Energy and its Environmental Effects','This course is a survey course designed to introduce basic physics concepts and applications, with emphasis placed on energy and the environment.',3.00,NULL),
		('PHY1053','General Physics I','First half of PHY1053/1054. Course covers vectors, systems of measurement, laws of motion, energy, heat, mechanical and thermal properties of matter.',3.00,50),
		('PHY1053L','General Physics I Lab','Lab component for; First half of PHY1053/1054. Course covers vectors, systems of measurement, laws of motion, energy, heat, mechanical and thermal properties of matter.',1.00,49),
		('PHY2048','Physics with Calculus I','First half of PHY2048/2049 sequence. Course covers kinematics of motion in one, two and three dimensions, vectors, dynamics, Newtons laws of motion, gravitation, work, power and energy; and systems of particles, wave motion and sound, heat and thermodynamics.',4.00,52),
		('PHY2048L','Physics with Calculus I Lab','Lab component for; First half of PHY2048/2049 sequence. Course covers kinematics of motion in one, two and three dimensions, vectors, dynamics, Newtons laws of motion, gravitation, work, power and energy; and systems of particles, wave motion and sound, heat and thermodynamics.',1.00,51),
		('PSC1121','Physical Science','Integrated principles of physical and earth sciences, the scientific method and selected areas of fundamental physics, chemistry, astronomy and meteorology.',3.00,NULL),

		/* Behavioral & Social Sciences Core */
		('DEP2004','Developmental Psychology','A study of the various aspects of normal human development, equally emphasizing tasks, changes and adjustments that occur in each stage of the life span.',3.00,NULL),
		('PSY1012','General Psychology','A scientific study of human behavior in relation to our development, motivation, emotion, perception learning and thinking.',3.00,NULL),
		('SYG2000','Introduction to Sociology','A systematic and scientific study of social behavior, including social organization, culture, deviance, cultural behavior and social institutions. This course contributes to satisfying the Gordon Rule (State Rule 6A-10.030) writing requirement.',3.00,NULL),

		/* Humanities, Cultural & Aesthetic Core */
		('AML2050','Modern American Literature','A survey of American writers covering roughly 1900-1950, emphasizing the modernist movement. Representative authors may include Faulkner, Hemingway, Fitzgerald, O-Neill, Cummings, Frost, Eliot, Pound. This course contributes to satisying the Gordon Rule (State Rule 6A-10.030) writing requirement.',3.00,NULL),
		('AML2060','Contemporary American Literature','A survey of American writers of the last fifty to sixty years, since 1950, including attention to postmodernist literature. This course contributes to satisfying the Gordon Rule (State Rule 6A-10.030) writing requirement.',3.00,NULL),
		('AML2600','Introduction to African American Literature','A survey of the African American history tradition from the eighteenth century to the present as reflected in a variety of oral and written traditions: songs, speeches, poetry, short-fiction, novels, drama, autobiographies, journals and letters. This course contributes to satisfying the Gordon Rule (State Rule 6A-10.030) writing requirement.',3.00,NULL),
		('ARH1000','Art Appreciation','A foundation for understanding the visual arts. This course contributes to satisfying the Gordon Rule requirement.',3.00,NULL),
		('ARH2050','Introduction to the History and Criticism of Art I','Survey and criticism of ancient, medieval, Renaissance and contemporary art and architecture; relation of styles to cultural context. This course contributes to satisfying the Gordon Rule requirement.',3.00,NULL),
		('DAN1100','Dance Appreciation','Lecture-based dance appreciation class. Extensive use of audio/visual materials which highlight the development of contemporary dance in America. This course contributes to satisfying the Gordon Rule (State Rule 6A-10.030) writing requirement.',3.00,NULL),
		('ENL2931','Selected Topics in Shakespeare','Course focuses on Shakespeares plays and poetry. Students read and view plays, including the study of staging, plot, characterization and language in Shakespearean works. This course contributes to satisfying the Gordon Rule (State Rule 6A-10.030) writing requirement. Course is also offered in SU as part of the Cambridge University Summer Program in Cambridge, England.',3.00,NULL),
		('HUM2210','Prehistory to Medieval Humanities','Literature, fine arts, music and philosophy of Western Europe from earliest times to the Renaissance, and their interrelation with the culture. This course contributes to satisfying the Gordon Rule (State Rule 6A-10.030) writing requirement.',3.00,NULL),
		('HUM2230','Renaissance to Postmodern Humanities','A continuation of HUM 2210, beginning with the high Renaissance and concluding with the early 20th century. This course contributes to satisfying the Gordon Rule (State Rule 6A-10.030) writing requirement. NOTE: HUM 2210 is NOT a prerequisite for HUMANITIES 2230.',3.00,NULL),
		('LIT2040','Dramatic Literature','A study of chronologically selected plays against the background of their periods, with emphasis upon the dramatic structure and universal dramatic themes. This course contributes to satisfying the Gordon Rule (State Rule 6A-10.030) writing requirement.',3.00,NULL),
		('LIT2110','Masterpieces of World Literature I','A study of world masterpieces from the time of the Old Testament through the Renaissance. This course contributes to satisfying the Gordon Rule (State Rule 6A-10.030) writing requirement.',3.00,NULL),
		('LIT2120','Masterpieces of World Literature II','A continuation of world masterpieces and national epics from the Renaissance to the 20th century and the Modern School. This course contributes to satisfying the Gordon Rule (State Rule 6A-10.030) writing requirement.',3.00,NULL),
		('LIT2380','Literature By Women','A study of women writers and the effects of history and historical changes projected through these writings from the 11th century through the present. This course contributes to satisfying the Gordon Rule (State Rule 6A-10.030) writing requirement.',3.00,NULL),
		('LIT2602','Maritime Literature','A study of readings from short stories, poetry, novels, and drama that deal with various issues concerning the oceans of the world. This course contributes to satisfying the Gordon Rule (State Rule 6A-10.030) writing requirement.',3.00,NULL),
		('MUH2110','Introduction to Music History and Literature','This is a survey course in music history and literature from the Middle Ages to the present. There will be an emphasis placed on the development of musical forms and performing mediums as they relate to Western Art Music through the ages.',3.00,NULL),
		('MUL1010','Music Appreciation','A survey course designed to establish a broad understanding of Western and Non-western musical styles. An emphasis will be placed upon critical listening skills, the recognition of fundamental musical elements and the roles of music in society from ancient to modern times. This course contributes to satisfying the Gordon Rule (State Rule 6A-10.030) writing requirement.',3.00,NULL),
		('MUL2380','Popular Music in America','This course looks at the events both social and musical that affected pop music in America. In addition, a timeline will be established and major artists contributions identified for the various periods of America pop culture. This course contributes to satisfying the Gordon Rule (State Rule 6A-10.030) writing requirement.',3.00,NULL),
		('THE1000','Dramatic Appreciation','An introduction to all the basic aspects of theater, including the play, the playwright, the actor, settings, and historical periods using a Golden Ages approach. This course contributes to satisfying the Gordon Rule (State Rule 6A-10.030) writing requirement. Attendance at productions required.',3.00,NULL),
		
		/* Historical & Global Core */
		('AMH2010','United States History to 1877','The political, economic, social and intellectual development of the people of the United States, from European exploration and settlement through the Civil War and Reconstruction. This course contributes to satisfying the Gordon Rule (State Rule 6A-10.030) writing requirement.',3.00,NULL),
		('AMH2020','United States History 1865 to Present','The political, economic, social and intellectual development of the people of the United States, from the Civil War to the present. This course contributes to satisfying the Gordon Rule (State Rule 6A-10.030) writing requirement.',3.00,NULL),
		('AMH2042','American Social History 1860 to Present','An examination of the cultural experiences, institutions and customs of American life and their effects on our common heritage, from 1860 to present times. This course contributes to satisfying the Gordon Rule (State Rule 6A-10.030) writing requirement.',3.00,NULL),
		('AMH2045','American Maritime History','An introductory course on American maritime history, tracing the impact of seafaring Americans and their related institutions and activities on American history from pre-colonial times to the present. This course contributes to satisfying the Gordon Rule (State Rule 6A-10.030) writing requirement.',3.00,NULL),
		('AMH2059','The Vietnam War','An introductory course on the Vietnam War, tracing the causes, and the effects of this conflict on United States and World History. The course will review the conflicts that occurred in Vietnam, from the time of French colonization to the present day. The course will also examine the ramifications that this conflict caused in the United States, and throughout the world. This course contributes to satisfying the Gordon Rule (State Rule 6A-10.030) writing requirement.',3.00,NULL),
		('AMH2091','Survey of African American History','A historical survey of African American experiences beginning with an overview of ancient African peoples, with emphasis on the experiences of Africans and their descendants in America.',3.00,NULL),
		('EUH2000','History of Western Civilization to 1648','An analysis of the major changes in the societies of western man, from the Middle Eastern origins through the Protestant Reformation. This course contributes to satisfying the Gordon Rule (State Rule 6A-10.030) writing requirement.',3.00,NULL),
		('EUH2001','History of Western Civilization from 1648 to Present','An examination of the historical evolution and diffusion of western institutions and ideas, including nationalism, the modern state, totalitarianism and democracy. This course contributes to satisfying the Gordon Rule (State Rule 6A-10.030) writing requirement.',3.00,NULL),
		('GEO2000','World Geography','A study of the Earth in spatial terms, place names of major countries and world regions, maps, globes and physical-human phenomena of environments and places.',3.00,NULL),
		('GEO2420','Cultural Geography','A descriptive study of the location and distribution of people in the world and their cultural characteristics, including: language, religion, and how people use resources and earn their livings.',3.00,NULL),
		('PHI2001','Introduction of Philosophy I','This course presents an introduction to an overview of the major areas of philosophy. It introduces the student to the methods of philosophy, some of the major questions addressed by philosophy and to a selection of the philosophies and philosophers found throughout the world from the ancient ages to the present. This course contributes to satisfying the Gordon Rule (State Rule 6A-10.030) writing requirement.',3.00,NULL),
		('PHI2600','Introduction to Ethics','An introduction to the key concepts and principles of ethics as a basis for the study of values, ethical decisions, right actions and justice. It covers the philosophical roots, as well as modern applications of ethics based upon the ideas and influence of many diverse philosophers, both classical and modern, Eastern and Western, female and male. This course contributes to satisfying the Gordon Rule (State Rule 6A-10.030) writing requirement.',3.00,NULL),
		('REL2300','World Religion','A comparative study of religion, with emphasis on Judaism, Christianity, Hinduism, Buddhism, Taoism, Confucianism, Shinto and Islam. This course contributes to satisfying the Gordon Rule (State Rule 6A-10.030) writing requirement.',3.00,NULL),
		('WOH2012','World History Before 1500','Survey of the major civilizations of the world from ancient times to the modern era. Emphasis on the development of civilization and the influence of encounter and exchange. This course contributes to satisfying the Gordon Rule (State Rule 6A-10.030) writing requirement.',3.00,NULL),
		('WOH2022','World History After 1500','An overview of the modern civilizations of Asia, Africa, Europe and the Americas. Emphasis on the development of new social, economic and political systems accompanied with intensified cultural exchange. This course contributes to satisfying the Gordon Rule (State Rule 6A-10.030) writing requirement.',3.00,NULL),
		
		/* Political, Economic & Business Core */
		('CPO2001','Comparative Government','An introduction to comparative political behavior, processes, institutions and public policy in selected industrial democracies, communist and former communist states and third world countries.',3.00,NULL),
		('ECO2013','Principles of Macro Economics ','An introduction to the fundamental principles and concepts of the U.S. national economy, including supply and demand analysis, national income accounting, economic growth, fiscal and monetary policy, business cycle theories and international trade. This course contributes to satisfying the Gordon Rule writing requirement.',3.00,NULL),
		('ECO2023','Principles of Micro Economics','An introduction to the fundamental principles and concepts of individual, business and government, including supply and demand, taxation price supports, plus analysis of labor, income distribution, politics, health care, and anti-trust. This course contributes to satisfying the Gordon Rule writing requirement.',3.00,NULL),
		('GEB2430','Business Ethics','The purpose of this course is to direct the student toward a professional level of ethical awareness and decision-making in business. A review of the historical origins of ethics and value systems and their influence on various cultures is included. Different ethical values are compared and reviewed in relation to current ethics issues and cases. This course contributes to satisfying the Gordon Rule (State Rule 6A-10.030) writing requirement.',3.00,NULL),
		('INR2002','International Relations','Analysis of national power, foreign policy, settlement of disputes, the balance of power system, and international organization and disarmament in world affairs.',3.00,NULL),
		('PLA2880','Constitutional Law','The course is developed both topically and historically to approach the judicial review process, the doctrine of implied powers, the three branches of government, substantive due process along with equal protection, civil rights, free speech and religion. This course contributes to satisfying the Gordon Rule (State Rule 6A-10.030) writing requirement.',3.00,NULL),
		('POS2001','Introduction to Political Science','A study of current political and economic issues in the United States, including international cases affecting American society.',3.00,NULL),
		('POS2041','American Federal Government','Constitutional rights of the individual; structure and functions of our legislative, executive and judicial branches; role of the citizen in political parties and the electoral process.',3.00,NULL),
		('POS2112','State and Local Government','Introduction to the principles and institutions of state and local government with emphasis on Florida. Explores the structures and functions of state governments, including federal-state and state-local relations.',3.00,NULL),

		/***** School of Computer Science *****/ 
		/* CAP - Computer Science */
		('CAP1801','Simulation Fundamentals','This is an introductory course in simulation technology. Students will learn the basic concepts in safety and housekeeping, basic sim-related software and hardware, instrumentation, documentation, and publications as related to the simulation industry.',3.00,NULL),
		('CAP2023','Introduction to Game Programming','During this course student will complete a ready-to-play, 3D animated game. This is a fast-paced, hands-on class to introduce the student to programming essentials, scripting, networking, GUI, textures, skins and 3D math. Students program clients and server modules; users interface; model and animate 3D characters, vehicles, terrains, and environments; program sound and music; and finally play test the finished game.',3.00,NULL),
		('CAP2804','Advanced Simulation Systems','The student will build on basic knowledge of simulator systems and operations gained in Simulation Fundamentals. Evaluation of simulator performance in comparison to requirements with consideration of government and manufacturing standards and statement of work documentation is included. Overall alignment procedures will also be covered.',4.00,NULL),
		('CAP2905','Directed Study in Simulation and Robotics','Directed Study in Simulation and Robotics.',4.00,NULL),
		('CAP2949','Cooperative Education Experience in Simulation and Robotics','(Prerequisite: 12 semester hours of approved Computer Science courses and permission of Computer Science chairperson.) FA, SP, SU Course does not show up in regular catalog schedule until you are registered. You are not officially registered until you have completed the Cooperative Education Learning Plan (with all signatures) and Cooperative Education Training Assignment/Registration. Required to complete 80-320 program contact hours in the field based on program 1-4 credit hour course requirement. (Average of 12-15 hours a week at an employer worksite) 1credit=80 contact hrs. 2credits=160 contact hrs. 3credits=240 contact hrs. 4credits=320 contact hrs. To register contact the Chairperson of your Department, or Cheryl Miller - Work Experience Coordinator millerc@DaytonaState.edu 386-506-4143 - Technology Campus',4.00,NULL),
		/* CEN - Computer Science */
		('CEN2002','Software Design and Development I','This course deals with the techniques used in analysis, design, and development of computer system software through data flow analysis and system development life cycle including traditional (and object) analysis, requirements analysis, specification, systems design, implementation, and maintenance.',3.00,NULL),
		/* CET - Computer Electronic Technology */
		('CET1112','Digital Fundamentals ','First course in digital theory covers number systems, including binary, octal, hexadecimal and decimal. Also includes logic gates, Boolean algebra, decoders, flip-flops, counters and programmable logic devices.',3.00,106),
		('CET1112L','Digital Fundamentals Lab','Lab component for; First course in digital theory covers number systems, including binary, octal, hexadecimal and decimal. Also includes logic gates, Boolean algebra, decoders, flip-flops, counters and programmable logic devices.',1.00,105),
		('CET1600','Network Plus','Basic concepts of network communication using the OSI model. Media, access protocols, routing, reliability, network services. Concepts of routing on an internet work. Prepares students for Network Plus certification exam.',4.00,NULL),
		('CET2123','Microcomputer and Basic Digital Communications','This course includes the architectural study of a microprocessor with its bus system and instruction set. An introduction to the principles of digital communications is also included in this course.',3.00,109),
		('CET2123L','Microcomputer and Basic Digital Communications Lab','Lab component for; This course includes the architectural study of a microprocessor with its bus system and instruction set. An introduction to the principles of digital communications is also included in this course.',1.00,108),
		('CET2154','A+ Computer Repair ','Designed to teach the fundamentals needed to perform assembly, upgrading, and servicing of PC hardware and operating systems. Covers the basic installation and function of current operating systems, multi-boot and maintenance utilities. Also introduces handheld devices such as notebooks, tablets, and PDAs. Course uses hands-on approach to learning, along with on-line content and A+ certified text to prepare students for the A+ exams.',4.00,NULL),
		('CET2615','Advanced Cisco Router Configuration','Advanced techniques in configuration of Cisco routers in Internet works, including utilization of configuration files downloaded from a TFTP server, employing advanced Cisco IOS EXEC commands.',4.00,NULL),
		('CET2620','Cisco Wide Area Network (WAN)','Routing WAN services and encapsulation, WAN design, PPP operation and authentication, ISDN capabilities and configuration, Frame Relay, subinterfaces and configuration. CCNA 640-607 certification exam.',4.00,NULL),
		('CET2625','Building Scalable Cisco Internetworks','The Building Scalable Cisco Internetworks (BSCI) course focuses on using Cisco routers connected in LANs and WANs typically found at medium to large network sites. Upon completion of this training course, students will be able to select and implement the appropriate Cisco IOS services required to build a scalable, routed network. BSCI is part of the recommended training path for those students seeking the Cisco Certified Network Professional (CCNP) and Cisco Certified Design Professional (CCDP).',4.00,NULL),
		('CET2626','Building Cisco Remote Access Networks','In the Building Scalable Remote Access Networks (BSRAN) course, students learn how to build, configure and troubleshoot a remote access network to interconnect central sites to branch offices and home offices. Students also learn how to control access to the central site, as well as to maximize bandwidth utilization over the remote links. BSRAN is part of the recommended training path for those students seeking the Cisco Certified Network Professional (CCNP), Cisco Certified Design Professional (CCDP), and Cisco Certified Internetwork Expert (CCIE) certifications.',4.00,NULL),
		('CET2660','Fundamentals of Network Security','This course introduces the student to the concepts and methods of securing a computer network. The course includes general security concepts, legal aspects of computer crime, cyber-crime culture, viruses, types of attack, communications security, cryptology, access control, firewalls, intrusion detection and disaster preparedness. This course prepares the student for the CompTIA Security+ certification. Students must have a thorough knowledge of TCP/IP prior to enrolling.',4.00,NULL),
		('CET2850','Wireless Networking','Site survey, installation, configuration, and troubleshooting of Wireless Local Area Networks. Basic RF and antenna theory.',4.00,NULL),
		('CET2949','Cooperative Education Experience in Computer Engineering Technology','(Prerequisite: 12 semester hours of approved Computer Science courses and permission of Computer Science chairperson.) FA, SP, SU Course does not show up in regular catalog schedule until you are registered. You are not officially registered until you have completed the Cooperative Education Learning Plan (with all signatures) and Cooperative Education Training Assignment/Registration. Required to complete 80-320 program contact hours in the field based on program 1-4 credit hour course requirement. (Average of 12-15 hours a week at an employer worksite) 1credit=80 contact hrs. 2credits=160 contact hrs. 3credits=240 contact hrs. 4credits=320 contact hrs. To register contact the Chairperson of your Department, or Cheryl Miller - Work Experience Coordinator millerc@DaytonaState.edu 386-506-4143 - Technology Campus',1.00,NULL),
		/* CGS - Computer Science */
		('CGS1002','Introduction to Microcomputer Operations','This is an introductory hands-on course that teaches the essentials of using the Windows Operating System. Emphasis on the use and management of the explorer, the taskbar, the desktop and menus, online help, disk tools and accessories.',1.00,NULL),
		('CGS1060','Basic Computer Concepts','This course is intended for first time computer users and concentrates on basic computer literacy. Students completing this course will have a concrete understanding of how to use a personal computer, manage computer files, use the Windows operating system and its various tools, send and receive e-mail and utilize the Internet to access information. Furthermore, the student will receive hands on experience with word processing, spreadsheet, presentation and other application programs. The course will be composed of classroom lectures together with hands-on computer exercises.',2.00,120),
		('CGS1060L','Basic Computer Concepts Lab','This course is intended for first time computer users and concentrates on basic computer literacy. Students completing this course will have a concrete understanding of how to use a personal computer, manage computer files, use the Windows operating system and its various tools, send and receive e-mail and utilize the Internet to access information. Furthermore, the student will receive hands on experience with word processing, spreadsheet, presentation and other application programs. The course will be composed of classroom lectures together with hands-on computer exercises.',1.00,119),
		('CGS1570','Introduction to Computer Applications','This is a short introductory course, which introduces students to word processing, spreadsheets, database and presentation software. Students participate in hands-on activities using these software applications.',1.00,NULL),
		('CGS2100','Microcomputer Applications','An introduction to computer operations including Windows operating system, e-mail, internet, and the use of software packages, including word processing, spreadsheets, data base management and presentation software.',3.00,NULL),
		('CGS2512','Advanced Computer Spreadsheets and Graphics Presentations','This course examines advanced spreadsheet techniques such as functions, formula development, what-if tables, and logic functions. Also covered is the planning and development of graphics presentations using animation, sound, charts, and narration.',3.00,NULL),
		('CGS2820','Web Programming (JavaScript, Ajax, ASP.Net)','This project-based course deals with a variety of web design tools used to access, design, and develop web sites. The students will be trained in techniques for creation and implementation of well-designed Dynamic Web sites using a design tool and a client side scripting language like JavaScript, Ajax, and server side technique with ASP.Net.',3.00,NULL),
		('CGS2821','Advanced Web Programming (XML, ASP.Net, SQL Server)','This course continues the participants development of skills using advanced web design techniques. Students will gain hands-on experience in creating and applying XML documents to web pages; understand XML mechanics and applications; manage XML data with ASP.Net and SQL Server programming.',3.00,NULL),
		('CGS2840','Secure Electronic Commerce','The student will learn about the history, present, and future of electronic commerce in the world. The student will also learn about the threats, vulnerabilities and policies when dealing with commerce in the electronic age.',4.00,NULL),
		('CGS2905','Directed Study in Computer Software Applications','Directed Study in Computer Software Applications.',4.00,NULL),
		/* CIS - Computer Science */
		('CIS2350','Principles of Information Assurance','This course introduces the student to basic security principles. Students will gain an understanding of the current threats and vulnerabilities in the cyber landscape, plus other topics relating to the information assurance field.',3.00,NULL),
		('CIS2381','Foundations of Digital Forensics','Digital forensics is the application of traditional forensic science principles and practices to the problem of electronically stored evidence. Students will receive an overview of the principles and practices of this emerging discipline to include the acquisition, examination and analysis of electronic evidence.',4.00,NULL),
		('CIS2905',' Directed Study in Computer and Information Systems','Independent individual or team studies, projects and practical in computer and information sciences under the direction of the Computer Science faculty. Specific content to be arranged. May be repeated with change of content. (Prerequisite: Permission of chairperson.)',4.00,NULL),
		('CIS2935','Computer Science Seminar','Discussion of computer programming work experience and special topics in computer science. (Prerequisite: permission of chairperson.)',1.00,NULL),
		('CIS2949','Cooperative Education Experience in Computer and Information Systems','(Prerequisite: 12 semester hours of approved Computer Science courses and permission of Computer Science chairperson.) FA, SP, SU Course does not show up in regular catalog schedule until you are registered. You are not officially registered until you have completed the Cooperative Education Learning Plan (with all signatures) and Cooperative Education Training Assignment/Registration. Required to complete 80-320 program contact hours in the field based on program 1-4 credit hour course requirement. (Average of 12-15 hours a week at an employer worksite) 1credit=80 contact hrs. 2credits=160 contact hrs. 3credits=240 contact hrs. 4credits=320 contact hrs. To register contact the Chairperson of your Department, or Cheryl Miller - Work Experience Coordinator millerc@DaytonaState.edu 386-506-4143 - Technology Campus.',2.00,NULL),
		/* CNT - Computer Networking */
		('CNT2402','Enterprise Security Management','This course will enable students to understand the principles of risk management, security architectures, incident handling, disaster recovery, and secure systems administration in Computer Networking.',3.00,NULL),
		/* COP - Computer Science */
		('COP1000','Principles of Computer Programming','This course provides the beginning programmer with a guide to developing structured program logic, and assumes no programming language experience. Programming concepts together with program definition, algorithms, flow charts, debugging, documentation, pseudocode, and a high-level language are introduced.',3.00,NULL),
		('COP2001','Computer Programming "C++"','A continuation of Computer Programming I using C. Object-oriented programming concepts and fourth generation languages will be introduced and applied.',2.00,136),
		('COP2001L','Computer Programming "C++" Lab','Lab component for; A continuation of Computer Programming I using C. Object-oriented programming concepts and fourth generation languages will be introduced and applied.',1.00,135),
		('COP2220','Computer Programming "C"','Hands-on, introductory study of C Programming language as applied to business applications. The course includes arrays, pointers, functions, I/O operations, data structures, and operating system interaction. Students write and compile their program in multiple platforms and compilers. Students also learn debugging techniques in existing malfunctioning programs and customize programs according to specifications.',3.00,NULL),
		('COP2360','C# Programming','This course is a programming course on the study of Microsoft Visual C# programming language with emphasis on object-oriented programming. Topics include control structures, methods, arrays, exception handling and inheritance.',3.00,NULL),
		('COP2654','IPhone/I Pad Programming','The students will be trained in techniques for creation and implementation of well-designed iPhone programs. The student applies the Objective-C programming language to create applications that run on iOS devices, including iPad, Phone, and iPod. Students will learn how to run apps on their own devices and how to distribute apps to the Apple Store.',3.00,NULL),
		('COP2660','Programming for Mobile Devices: Android','This is a programming course designed to develop Android-based Applications for mobile devices and tablets. It will use the Android Software Development Kit (SDK) to create and test Apps on the Android Emulator and/or on students own devices. Topics include User Interface Layouts and Views, Event Handling, and Publishing an App.',3.00,NULL),
		('COP2700','Introduction to Database Management','This class covers the concepts of relational databases and the industry standard SQL language. Students are taught the relational model to create and maintain database objects. Data analysis, logical and physical structure will be covered. Students will learn data definition language and data manipulation language syntax in SQL. CASE tools will be used to analyze data structure.',3.00,NULL),
		('COP2800','Computer Programming "Java"','The high-level computer language java is used to solve business problems. Course includes basics, object-oriented programming, graphical user interfaces with event-driven programming and applets used in web pages.',3.00,NULL),
		('COP2805','Advanced Computer Programming "Java"','This course expands on the Java programming basics to explore advanced Java topics such as inner classes, object serialization, and multithreading. Many of the objectives for Sun Java Certification are covered.',3.00,NULL),
		('COP2842','Web Scripting (PHP)','This course is designed to teach Web server-side programming skills. Students completing this course will be able to develop a complete Web side, maintain and manage the Web site. Students will learn the essentials of Web server-side programming language, database, and server, write server-side programming code, integrate the code into Web pages, and identify different uses and applications of scripts in Web sites and/or other multimedia projects.',3.00,NULL),
		('COP2850','Web Programming Project','Upon completion of this project based course students will write a proposal, create project development plan, understand the project development procedure, demonstrate the computer skills, implement the project, test and deploy the complete system on the web server.',3.00,NULL),
		('COP2905','Directed Study in Computer Programming','Independent individual or team studies, projects and practica in computer programmingdesign, construction, documentation and implementation-under the direction of the Computer Science faculty. Specific content to be arranged. May be repeated with change of content. (Prerequisite: Permission of Computer Science chairperson.)',4.00,NULL),
		('COP2940','Computer Science Internship','Six hours per week of practical computer programming experience in a computer installation.',2.00,NULL),
		('COP2949','Cooperative Educational Experience in Computer Programming','Prerequisite: 12 semester hours of approved Computer Science courses and permission of Computer Science chairperson.) FA, SP, SU Course does not show up in regular catalog schedule until you are registered. You are not officially registered until you have completed the Cooperative Education Learning Plan (with all signatures) and Cooperative Education Training Assignment/Registration. Required to complete 80-320 program contact hours in the field based on program 1-4 credit hour course requirement. (Average of 12-15 hours a week at an employer worksite) 1credit=80 contact hrs. 2credits=160 contact hrs. 3credits=240 contact hrs. 4credits=320 contact hrs. To register contact the Chairperson of your Department, or Cheryl Miller - Work Experience Coordinator millerc@DaytonaState.edu 386-506-4143 - Technology Campus.',1.00,NULL),
		/* CTS - Computer Science */
		('CTS1851','Internet Web Foundations (HTML, CSS)','An introductory course designed to teach the basic hands-on skills and knowledge that todays business and Internet professionals are expected to understand and use. The three major topics covered are: Fundamental uses of the Internet, web page design, and web page development and publishing including the use of HTML, CSS, and various fundamental web server management skills. Students will perform a variety of practical tasks and assignments.',3.00,NULL),
		('CTS2141','Advanced C++ and Direct X Programming','The student applies the Objective C programming language to create applications that run on iOS devices, including iPad, iPhone, and iPod. The XCode development environment will be used to create and test apps. Students will learn how to run apps on their own devices and how to distribute apps to the AppStore. Owning an iOS device is not necessary, since XCode includes a simulator. Online students will either need access to an Apple computer or notebook running OS X Snow Leopard or later, or will need to work in the schools Apple computer lab.',3.00,NULL),
		('CTS2214','Project Management w/Microsoft Project','This course provides an introduction to the basic elements of Project Management. Students build project plans using Microsoft Project software. The text used covers the objectives for the Microsoft Office Specialist (MOS) "core" certificate.',3.00,NULL),
		('CTS2300','Designing Windows Networks','Design a Windows Network infrastructure using network services. Topics include protocols, IP routing, DHCP, DNS, WINS, NAT, Proxy server, RAS, VPN, RADIUS, monitoring, DFS and optimization. MCP Exam 70-221, a core requirement for MCSE.',4.00,NULL),
		('CTS2302','Microsoft Windows Active Directory Services','Implementation, administration and troubleshooting Windows Active Directory Services. Learn how to plan, create and maintain user and group accounts and profiles. Additional topics, such as DNS name resolution, zone, NTFS permissions and DFS will be discussed. MCP Exam 70-217, a core requirement for MCSE.',4.00,NULL),
		('CTS2303','Designing Windows Active Directory Services','Design a Microsoft Windows® directory services infrastructure in an enterprise network. Strategies are presented to assist the student in identifying the information technology needs of an organization, and then designing an Active Directory structure that meets those needs. MCP Exam 70-219, a core requirement for MCSE.',4.00,NULL),
		('CTS2306','Microsoft Windows Professional','Installing, configuring and supporting Microsoft Windows Professional in a workgroup or domain to prepare for MCP Exam 70-270, a core requirement for MCSA and MCSE certifications.',4.00,NULL),
		('CTS2310','Designing Windows Network Security','Design a security framework for small, medium and enterprise networks by using Microsoft Windows technologies. This course focuses on securing specific areas of the network. MCP Exam 70-220, a core requirement for MCSE.',4.00,NULL),
		('CTS2311','Linux Networking and Security','This is an advanced course in the Linux operating system emphasizing installing, configuring and using Linux networking services. It also stresses securing the Linux OS in a networked environment. Topics include configuring and using basic networking connectivity, Linux clients, SNMP, mail lists and news servers, email servers, DNS servers, file sharing, FTP servers, NFS, Samba, cryptographic security, password security, file security, routing, firewalls, and intrusion detection. Previous experience with Linux installation and configuration is required.',4.00,NULL),
		('CTS2320','Implementing, Managing and Maintaining a Windows Network Infrastructure','Introduction to primary protocols and network services required to plan and design a Windows network infrastructure. Topics include TCP/IP, NWLink, DNS, WINS, WINS, DHCP, RAS, Network Monitor, IPSec, NAT and Certificate Services. Exam 70-216, a core requirement for MCSA and MCSE certifications. (Prerequisite: CEN 2304 or permission of Computer Science chairperson.)',4.00,NULL),
		('CTS2321','Linux System Administration','This course is designed to teach students the skills they need to effectively administer the Linux operating system. The course includes Linux server installation, configuration, administration, networking services, security, system maintenance, and troubleshooting tasks. Previous experience with computer hardware configuration, network services and network operating systems is required.',4.00,NULL),
		('CTS2328','Managing and Maintaining a Windows Network Environment','Manage a network infrastructure, services and resources to prepare for MCP Exam 70-290, a core requirement for MCSA certification and an elective for MCSE certification.',4.00,NULL),
		('CTS2330','Microsoft Exchange Server Implementation and Administration','Install, configure, administer and troubleshoot Microsoft Exchange Server. Acquire the knowledge and skills required to perform day-to-day management of an Exchange Server organization. Prepare for MCSE Exam 70-224 an elective for Windows MCSE track.',4.00,NULL),
		('CTS2370','Virtualization Infrastructure: Installation and Configuration','In this course, students learn the concepts and capabilities of virtual architecture with a focus on the installation, configuration, and management of a VMware virtual infrastructure. This course covers fundamentals of virtual network design and implementation, fundamentals of storage area networks, virtual switching, virtual system management, and engineering for high availability.',4.00,NULL),
		('CTS2402','Visual Basic Programming','A first course in object-oriented programming using Microsoft Visual BASIC.NET for Windows. Topics covered will be the programming environment and how to use it, use of programming values and variables, conditional statement and loops, modules and parameter passing and use of color and windows forms for communication with the user. An introduction to ASP.NET and database access will be covered.',3.00,NULL),
		('CTS2403','Advanced Visual Basic Programming','The student applies the Visual Basic programming language to more advanced problems including accessing SQL Server databases, creating Web forms, and creating custom controls. The student designs, implements and documents computer programs using Microsofts Visual Basic.NET development environment. This course covers competencies of the developing and implementing Windows-based Applications with Microsoft Visual Basic.NET and Visual Studio.NET exam (70-306) of the Microsoft Certified Application Developer (MCAD) certification.',3.00,NULL),
		('CTS2431','Data Organization and Management','Advanced concepts using Microsoft Access. Topics covered include creating table structures, enforcing referential integrity, creating and modifying forms, creating and modifying reports and saving objects as Web pages. This course covers topics required by the Microsoft Office Specialist (MOS) certification exam.',2.00,166),
		('CTS2341L','Data Organization and Management Lab','Lab component for; Advanced concepts using Microsoft Access. Topics covered include creating table structures, enforcing referential integrity, creating and modifying forms, creating and modifying reports and saving objects as Web pages. This course covers topics required by the Microsoft Office Specialist (MOS) certification exam.',1.00,165),
		('CTS2801','Web Application Development - ActionScripting','This course is designed to teach Web server-side programming skills. Students completing this course will be able to develop a complete Web side, maintain and manage the Web site. Students will learn the essentials of Web server-side programming language, database, and server, write server-side programming code, integrate the code into Web pages, and identify different uses and applications of scripts in Web sites and/or other multimedia projects.',3.00,NULL),
		/* DIG - Digital Media */
		('DIG1109','Digital Imaging Fundamentals','This course covers digital image manipulation, editing and file management techniques using industry software. Introduces students to personal computers, the Macintosh Operating System and peripheral devices as graphic production tools for design, photography and digital media.',3.00,NULL),
		('DIG2100','Web Design I','An introduction to professional tools, techniques and methods used in web publishing. Current industry production software is used to create and edit electronic pages, layouts and websites. This course is repeatable one time for credit.',3.00,NULL),
		/* EET - Electronic Engineering Technology */
		('EET1011','Introduction to Electrical Circuits','An introduction to the basic concepts of electricity and magnetism. Emphasis is placed on resistance, capacitance and inductance as basic circuit components.',2.00,171),
		('EET1011L','Introduction to Electrical Circuits Lab','Lab component for; An introduction to the basic concepts of electricity and magnetism. Emphasis is placed on resistance, capacitance and inductance as basic circuit components.',1.00,170),
		('EET1021','Advanced Electrical Circuits','An introduction to the basic concepts of alternating voltage and current. Emphasis is placed on resistance, capacitance and inductance as basic AC circuit components.',2.00,173),
		('EET1021L','Advanced Electrical Circuits Lab','Lab component for; An introduction to the basic concepts of alternating voltage and current. Emphasis is placed on resistance, capacitance and inductance as basic AC circuit components.',1.00,172),
		('EET1141','Analog Devices and Circuits','Introduces the concepts of circuit simplification via idealizations, approximations and an overview of semiconductor devices and their electrical properties. Emphasis is placed on circuit analysis.',3.00,175),
		('EET1141L','Analog Devices and Circuits Lab','Lab component for; Introduces the concepts of circuit simplification via idealizations, approximations and an overview of semiconductor devices and their electrical properties. Emphasis is placed on circuit analysis.',1.00,174),
		('EET1607','Electronics Assembly and Cabling','This course involves lab environment training in communications cabling and electronics assembly techniques. Topics covered include computer network cable fabrication, installation, and management, safety, testing and troubleshooting, cabling industry standards, component recognition, soldering and desoldering methods, and reading and drawing of schematics.',2.00,177),
		('EET1607L','Electronics Assembly and Cabling Lab','Lab component for; This course involves lab environment training in communications cabling and electronics assembly techniques. Topics covered include computer network cable fabrication, installation, and management, safety, testing and troubleshooting, cabling industry standards, component recognition, soldering and desoldering methods, and reading and drawing of schematics.',1.00,176),
		('EET2142','Analog Circuits and Basic Analog Communications','Circuits covered are more complex in applications. Includes FET circuitry, amplitude/phase shift response of transistor circuits, integrated circuits and negative and positive feedback circuits.',3.00,179),
		('EET2142L','Analog Circuits and Basic Analog Communications Lab','Lab component for; Circuits covered are more complex in applications. Includes FET circuitry, amplitude/phase shift response of transistor circuits, integrated circuits and negative and positive feedback circuits.',1.00,178),
		('EET2326','Wireless Communications','A comprehensive study of electronic communication systems, including topics in fiber optic, AM/FM radio, transmission lines, antennas, wave propagation, microwave techniques and other broadcast technologies.',3.00,181),
		('EET2326L','Wireless Communications Lab','Lab component for; A comprehensive study of electronic communication systems, including topics in fiber optic, AM/FM radio, transmission lines, antennas, wave propagation, microwave techniques and other broadcast technologies.',1.00,180),
		('EET2905','Directed Study in Electronics','Directed Study in Electronics.',4.00,NULL),
		('EET2949','Cooperative Education Experience in Electronics','(Prerequisite: 12 semester hours of approved Computer Science courses and permission of Computer Science chairperson.) FA, SP, SU Course does not show up in regular catalog schedule until you are registered. You are not officially registered until you have completed the Cooperative Education Learning Plan (with all signatures) and Cooperative Education Training Assignment/Registration. Required to complete 80-320 program contact hours in the field based on program 1-4 credit hour course requirement. (Average of 12-15 hours a week at an employer worksite) 1credit=80 contact hrs. 2credits=160 contact hrs. 3credits=240 contact hrs. 4credits=320 contact hrs. To register contact the Chairperson of your Department, or Cheryl Miller - Work Experience Coordinator millerc@DaytonaState.edu 386-506-4143 - Technology Campus.',4.00,NULL),
		/* EGS - Engineering (Support) */
		('EGS1000','Professional Performance for Technicians','Introduction to professional training activities related to organizations including interpersonal relationships, problem solving, goal settings, ethics, policy and procedures, personal development and organizational structures and cultures.',3.00,NULL),
		('EGS2905','Directed Study in Electronics','Directed Study in Engineering.',4.00,NULL),
		/* ETM - Engineering Technology (Mechanical) */
		('ETM2315','Simulation Power and Control','Electro-mechanical, Hydraulics and Pneumatics A practical approach to technical problems involving hydraulics and pneumatics, fluid mechanics, hydrostatic forces, and pipe and pump operation including the electrical circuitry needed to operate and control mechanical and hydraulic/pneumatic systems.',2.00,187),
		('ETM2315L','Simulation Power and Control Lab','Lab component for; Electro-mechanical, Hydraulics and Pneumatics A practical approach to technical problems involving hydraulics and pneumatics, fluid mechanics, hydrostatic forces, and pipe and pump operation including the electrical circuitry needed to operate and control mechanical and hydraulic/pneumatic systems.',1.00,186),
		
		/***** College of Technology *****/
		/* CET - Computer Electronic Technology */
		('CET3010','Introduction to Information Technology','An introduction to how information drives the business enterprise, how information technologies support business processes and how business, IT and information are managed in modern enterprises.',3.00,NULL),
		('CET3116','Digital Technology','Class provide Digital logic gates, memory devices, Karnaugh Maps, combinational logic, arithmetic units, registers and sequential logic.',4.00,NULL),
		('CET3198','Digital Systems','Finite State Machines and Algorithmic State Machines,includes design, synthesis and implementation of a digital syatem using schematic capture and VHDL.',2.00,191),
		('CET3198L','Digital Systems Lab','Hands on lab component for; Finite State Machines and Algorithmic State Machines,includes design, synthesis and implementation of a digital syatem using schematic capture and VHDL.',1.00,190),
		('CET3383','Software Engineering I','Study of system analysis, design, development, and implementation cycle. Includes Object Orientated programming (OOP) to implement system programs.',3.00,NULL),
		('CET3679','Telecommunications I','An introductory level course in telephony technology. The telephony environment, telemanagement, telephony, connectivity, and services of telephony.',3.00,NULL),
		('CET3906','Directed Study in Computer Engineering Technology','Independent Study.',3.00,NULL),
		('CET4134','Microprocessor Electronics II','Discussion of MC68000 Software architecture programming and hardware architecture. Additionally,assembly language programming interfacing and hardware are discussed.',2.00,196),
		('CET4134L','Microprocessor Electronics II Lab','Lab component supporting lecture in discussion of MC68000 Software architecture programming and hardware architecture. Additionally,assembly language programming interfacing and hardware are discussed.',1.00,195),
		('CET4138','Programmable Digital Devices','Architecture and applications of various types of programmable logic devices. Design entry, methods, e.g. HDL, schematic capture, etc. Lab exercises using PALS, PLDs, and FPGS.',2.00,198),
		('CET4138L','Programmable Digital Devices Lab','Architecture and applications of various types of programmable logic devices. Design entry, methods, e.g. HDL, schematic capture, etc. Lab exercises using PALS, PLDs, and FPGS.',1.00,197),
		('CET4333','Computer Organization and Design','Basic computer systems design and architecture. An introduction to design of computer memories, CPU s, I/O devices, buses, and addressing schemes.',3.00,NULL),
		('CET4483','Telecommunications II','An introductory level course in local area networks. Topics in data communications, computer networking, local area network technology, topologies, and protocols will be covered.',3.00,NULL),
		('CET4505','Operating Systems I','Concepts involved with modern operating system. Topics include memory, processor, process, device, file, and systems management, concurrency and deadlock of resources, security and ethics, as well as various operating systems including UNIX, Windows, and Linux.',3.00,NULL),
		('CET4663','Computer and Network Security','Course covers knowledge and skills for securing computers and networks. Topics include: risk analysis and management, methods of authentication and auditing, TCP/IP, identifying network attacks using packet captures, firewalls, cryptography, and network/host-based intrusion detection systems. This is a hands-on course that requires prior knowledge of computers, networking principles and Linux.',3.00,NULL),
		('CET4668','Practice of Information Security','Practice of Information Security including technical security issues, legal issues, physical and operational security, and security,architecture and models.',3.00,NULL),
		('CET4748','Telecommunications III','Designing Wide Area Networks; determining requirements, designing the networks, structure, choosing appropriate technologies, and evaluating results.',3.00,NULL),
		('CET4860','Introduction to Digital Forensics','Topics will include; forensic process; forensic duplication; authentication; file recovery; file systems; FAT file system; digital artifacts, and various digital forensic tools.',3.00,NULL),
		('CET4861','Advanced Digital Forensics','Topics include forensic process, NTFS, EXT, HFS+ file systems, Windows registry forensics, RAM and SWAP capture, and mobile device forensics. This is a hands-on course that requires prior knowledge of computer systems and Linux.',3.00,NULL),
		('CET4862','Network Forensics and Incident Response','Course covers identification, recovery and analysis of forensic artifacts from computer and network intrusions. Topics include: incident handling, malware analysis, identifying and recovery evidence of intrusions, data hiding, and identifying network-based attacks. This is a hands-on course that requires prior knowledge of networking and Linux.',3.00,NULL),
		('CET4884','Security Methods and Practice','An introduction to the fundamentals of how an enterprises information, technology, facilities and people are protected. This includes business, legal, human resources and technology issues.',3.00,NULL),
		('CET4885','Digital Forensics for Information Security','This course will provide students with the fundamental principles of digital forensics with an emphasis on the skills needed by information security professionals.',3.00,NULL),
		/* CIS - Computer Science */
		('CIS4510','IT Project Management','This course introduces concepts, methodologies, techniques and tools of managing software development. In addition; hardware, computer networks and communication systems configuration will be provided.',3.00,NULL),
		/* COP - Computer Science */
		('COP4708','Applied Database I','Design and implementation of data base systems within the concept of central administration, structured data storage. Programming project is required.',3.00,NULL),
		('COP4709','Applied Database II','Study of relational and other database system. Advanced SQL query and programming, decision support systems, and advanced database topics are covered.',3.00,NULL),		
		('COP4813','Web Systems I','Introduction to web systems with emphasis on server configuration, web standards, page design, use of XML, Javascript for client interactivity, and accessibility standards. Extensive computer programming with Javascript and HTML5 will be performed.',3.00,NULL),
		('COP4834','Web Systems II','Advanced web design with server side technology (focus on .NET) is covered. Students will develop, test, and publish database driven web sites using cloud based servers and .NET publishing standards including code management. Programming project is required.',3.00,NULL),
		/* COT - Computer Science */
		('COT3100','Discrete Computational Analysis','This course applies basic mathematical logic skills and foundations used in Computer Science and Information Technology. Topics include logic rules, tautologies, boolean algebra, set theory, mathematical induction and other topics of discrete computational analysis.',3.00,NULL),
		/* CTS - Computer Science */
		('CTS3348','Linux Administration','Student will learn how a system administrator fulfills various organizational information resource management requirements using a Linux-based operating system. Topics include; installation; creating and maintaining file systems; user and group administration; backup and restore processes; network configuration; managing system services; security administration; and updating and maintaining the system.',3.00,NULL),
		/* EET - Electronic Engineering Technology */
		('EET3085','Electricity and Electronics','Basic theorems and circuit analysis techniques. Instruments and measurements. Introduction to integrated circuits.',3.00,218),
		('EET3085L','Electricity and Electronics Lab','Lab Component for; Basic theorems and circuit analysis techniques. Instruments and measurements. Introduction to integrated circuits.',1.00,217),
		('EET3086','Principles of Electrical Circuits','DC, AC circuits and electronics. Theorems and circuit analysis techniques. Introduction to transducers, instrumentation, measurements and circuits simulation.',3.00,NULL),
		('EET3716','Network Analysis','Transient analysis of first and second-order circuits, circuit analysis using LaPlace Transforms. Transform function, frequency response analysis, and Bode plots.',3.00,NULL),
		('EET4158','Linear Integrated Circuits','Applications of operational amplifiers, comparators, phase-locked loops, timers, regulators, other integrated circuits. Includes amplifiers, active filters, oscillators, differentiators and integrators.',3.00,222),
		('EET4158L','Linear Integrated Circuits Lab','Lab Component for; Applications of operational amplifiers, comparators, phase-locked loops, timers, regulators, other integrated circuits. Includes amplifiers, active filters, oscillators, differentiators and integrators.',1.00,221),
		('EET4329','Communications Systems','Principles and interrelationships of communication system components and circuits. Signals, noise, modulation, demodulation, bandwidth requirements. Transmitters and receivers. Course descriptions are updated from time to time with new relevant information.',3.00,224),
		('EET4329L','Communications Systems Lab','Lab Component for; Principles and interrelationships of communication system components and circuits. Signals, noise, modulation, demodulation, bandwidth requirements. Transmitters and receivers. Course descriptions are updated from time to time with new relevant information.',1.00,223),
		('EET4732','Feedback Control Systems','"Analysis of networks and control systems. Stability and Compensation considerations, root locus, Nichols chart and Bode plots. Simulation techniques, systems components."',3.00,226),
		('EET4732L','Feedback Control Systems Lab','Lab component for; Analysis of networks and control systems. Stability and Compensation considerations, root locus, Nichols chart and Bode plots. Simulation techniques, systems components SP',1.00,225),
		/* EGN - Engineering (General/Support) */
		('EGN3311','Statics','This course covers fundamental concepts and laws of mechanics, coordinate systems and resultants of force systems, free-body diagrams, center of gravity, centroid, moment of inertia, equilibrium of rigid bodies, friction, and analyses of structures.',3.00,NULL),
		('EGN3343','Thermodynamics','This course will allow students to develop an understanding and solve problems related to work, heat, energy transformations, and relation of properties: including laws, concepts, and modes of analysis common to all applications of thermodynamics in engineering.',3.00,NULL),
		('EGN3613','Engineering Economics Analysis','The course covers application of principles of engineering economy for establishment of equipment and system feasibility with emphasis on economic evaluation of engineering alternatives. Included are calculating project costs, incorporating interest rates, tax implications, risk, and depreciation to assess the relative worth of engineering and generic investment alternatives.',3.00,NULL),
		/* ETC - Engineering Technology (Civil) */
		('ETC4206','Construction Estimating','Techniques of making estimates and computations of materials, labor, equipment, overhead costs and profits. Software packages are utilized.',3.00,NULL),
		('ETC4241','Construction Materials and Methods','Construction principles, details, materials and methods used as related to the construction of buildings.',2.00,232),
		('ETC4241L','Construction Materials and Methods Lab','Lab Component for; Construction principles, details, materials and methods used as related to the construction of buildings.',1.00,231),
		('ETC4414','Structural Steel Design','Introduction to indeterminate analysis, design of steel members, components and connections using current code and specification requirements.',2.00,234),
		('ETC4414L','Structural Steel Design Lab','Lab Component for; Introduction to indeterminate analysis, design of steel members, components and connections using current code and specification requirements.',1.00,233),
		('ETC4415','Structural Concrete Design','Strength design of reinforced concrete members, foundations, slabs,and walls. Current code and specification requirements.',2.00,236),
		('ETC4415L','Structural Concrete Design Lab','Lab Component for; Strength design of reinforced concrete members, foundations, slabs,and walls. Current code and specification requirements.',1.00,235),
		/* ETG - Engineering Technology (General) */
		('ETG3533','Engineering Strength of Materials','Relationship between external forces and action of members of a structure. Topics include stress, shear, moment, deflections, columns, connections, and Mohrs circle.',2.00,238),
		('ETG3533L','Engineering Strength of Materials Lab','Lab Component for; Relationship between external forces and action of members of a structure. Topics include stress, shear, moment, deflections, columns, connections, and Mohrs circle.',1.00,237),
		('ETG3541','Applied Mechanics','Coplanar, parallel, concurrent, and non-concurrent force systems. Centroids, centers of gravity, and moments of inertia. Principles of dynamics, rectilinear motion and rotation, work, energy, power, impulse, momentum, and impact.',3.00,NULL),
		('ETG3907','Directed Study in Industrial Systems','Independent Study',3.00,NULL),
		('ETG4950','Project Management and Senior Design II','The development of prototype or a full scale product as team work that will involve all techniques and tools learned from Senior Design I, supervised by department faculty of specialization required to support product development.',2.00,242),
		('ETG4950L','Project Management and Senior Design II Lab','Lab Component for; The development of prototype or a full scale product as team work that will involve all techniques and tools learned from Senior Design I, supervised by department faculty of specialization required to support product development.',1.00,241),
		/* ETI - Engineering Technology (Industrial) */
		('ETI3116','Engineering Quality Assurance','This course covers the fundamentals of quality improvement tools and techniques, concepts and methods for quality design and control including statistical process control, control charts, process capability, and the latest quality initiatives and approaches such as Lean Enterprise and Six Sigma.',3.00,NULL),
		('ETI3421','Materials and Processe','A study of fundamental properties of materials. Current industrial practices in founding, forming, joining and shaping processes.',3.00,NULL),
		('ETI3671','Technical Economics Analysis','Analysis of cost elements in technical operations. Basis for comparison of alternatives.',3.00,NULL),
		('ETI3690','Technical Sales','This course covers application of technical knowledge to sales and service; relationship of technical sales organization to production, customers, and competitors; and technical knowledge with sales skills to provide advice and support on a range of products.',3.00,NULL),
		('ETI4186','Applied Reliability','This course covers practical application of reliability concepts and the analysis applicable to design, development, production, logistic, and operation phases of system components. Principal methods of reliability analysis, including Failure Mode and Effects Analysis (FMEA) and reliability data collection and analysis.',3.00,NULL),
		('ETI4205','Applied Logistics','This course emphasizes on practical applications. Includes systems engineering, cost/systems effectiveness, reliability, maintainability, system functional analysis, logistic support, analysis, life cycle cost analysis. It covers everything from organizing the manpower needed to run a management system, planning maintenance, meeting equipment needs and keeping documentation in order. By becoming familiar with these needs, students can create effective and practical support and logistics systems that are easy to maintain and manage.',3.00,NULL),
		('ETI4448','Project Management and Senior Design I','Statement of work, activity decisions, timelines, scheduling and resource allocation methods. Techniques will be appropriate for large and small projects within commercial, academic, or non-profit organizations.',3.00,NULL),
		('ETI4635','Technical Administration','This course provides an overview of the techniques of applying management principles to professional positions held by Engineering Technologists and Engineers. The management functions of planning, organizing, leading, and controlling are discussed with their role in managing technology.',3.00,NULL),
		('ETI4640','Operations Management','The course will provide an overview of the tools and techniques used in the ten important decision areas related to operations. The course will also review realistic case studies for best practices in decision making and operations management.',3.00,NULL),
		/* ETM - Engineering Technology (Mechanical) */
		('ETM4512','Design of Machine Elements','Design of basic machine elements, including cams, gears, bearings, and coupling, taking into account loads, stresses, and strength of materials.',3.00,NULL),
		/* ETP - Engineering Technology (Power) */
		('ETP4240','Power Systems','Analysis of electrical power systems and energy conversion. 3-phase load, per-unit quantities, circuit constants rotating machines, 3-phase transformers, transmission lines, power flow, stability and fault calculations.',3.00,254),
		('ETP4240L','Power Systems Lab','Lab Component for; Analysis of electrical power systems and energy conversion. 3-phase load, per-unit quantities, circuit constants rotating machines, 3-phase transformers, transmission lines, power flow, stability and fault calculations.',1.00,253),
		/* ETS - Engineering Technology (Specialty) */
		('ETS3543','Programmable Logic Applications and Device','This course presents logic fundamentals, programming technologies, integrated circuits, and number systems to operate and test systems using programmable logic protocol. Use of program control instructions and Data Manipulation with I/O instructions and addresses in laboratory exercises.',2.00,256),
		('ETS3543L','Programmable Logic Applications and Device Lab','Lab Component for; This course presents logic fundamentals, programming technologies, integrated circuits, and number systems to operate and test systems using programmable logic protocol. Use of program control instructions and Data Manipulation with I/O instructions and addresses in laboratory exercises.',1.00,255),
		('ETS4502','Metrology and Instrumentation','An introduction to the basic concepts and terminology of metrology and instrumentation. Theory, procedures and techniques essential to industrial measurement and laboratory practice are covered. (Prerequisites: ETG 3541 or equivalent; EET 3085 or equivalent; and MAC 2253 or equivalent.)',2.00,258),
		('ETS4502L','Metrology and Instrumentation Lab','Lab Component for; An introduction to the basic concepts and terminology of metrology and instrumentation. Theory, procedures and techniques essential to industrial measurement and laboratory practice are covered. (Prerequisites: ETG 3541 or equivalent; EET 3085 or equivalent; and MAC 2253 or equivalent.)',1.00,257),
		/* MAP - Mathematics (Applied) */
		('MAP3401','Problem Analysis','Application of Calculus in Solving Engineering Technology Problems.',3.00,NULL),
		/***** Additional Courses needed to fulfill Major degree requirements *****/
		('PHY1054','General Physics II','Second half of PHY1053/1054. Continuation of PHY1053. Course covers sound, wave motion, electrostatics, magnetism and physical and geometrical optics.',3.00,261),
		('PHY1054L','General Physics II Lab','Lab component for; Second half of PHY1053/1054. Continuation of PHY1053. Course covers sound, wave motion, electrostatics, magnetism and physical and geometrical optics.',1.00,260),	
		('ETD2357','Inventor Solid Modeling','Beginning course in 3D modeling using AutoDesk INVENTOR software. Topics include generation of engineering drawings and animated presentations from part and assembly models. Course work intended to prepare students for the INVENTOR User Certification Test.',2.00,263),
		('ETC2357L','Inventor Solid Modeling Lab','Lab Component for; Beginning course in 3D modeling using AutoDesk INVENTOR software. Topics include generation of engineering drawings and animated presentations from part and assembly models. Course work intended to prepare students for the INVENTOR User Certification Test.',1.00,262),	
		('ETD2377','3D Computer Animation (3D Studio)','An introductory course in 3D animation for technical graphics that includes object creation, editing, lighting, materials, keyframing and rendering.',2.00,265),
		('ETC2377L','3D Computer Animation (3D Studio) Lab','Lab Component for; An introductory course in 3D animation for technical graphics that includes object creation, editing, lighting, materials, keyframing and rendering.',1.00,264);
		
INSERT INTO Degree (Code, Title)
VALUES ('AS','Associates of Science Degree'),
		('AA','Associates of Arts Degree'),
		('BS','Bachelor of Science Degree'),
		('BAS','Bachelor of Applied Science Degree'),
		('VOC','Vocational Certificate'),
		('ASC','Associates of Science Certificate'),
		('ATC','Applied Technical Certificate'),
		('ATD','Applied Technical Diploma'),
		('APP','Apprenticeship');

INSERT INTO Category (Title)
VALUES ('AA/AS Program of Study'),
		('General Education Courses'),
		('Program Specific Courses'),
		('General Education - Core'),
		('General Education - Electives'),
		('Lower Level - Core'),
		('Lower Level - Electives'),
		('Upper Level - Core'),
		('Upper Level - Electives'),
		('Communications Core'),
		('Mathematics Core'),
		('Behavioral & Social Sciences Core'),
		('Humanities, Cultural & Aesthetic Core'),
		('Sciences (Biological & Physical) Core'),
		('Health & Wellness Core'),
		('Political, Economic & Business Core'),
		('Historical & Global Core'),
		('Computer Programming Option'),
		('Biological Science Core'),
		('Physical Science Core'),
		('Security Concentration Elective'),
		('CISCO Concentration Elective'),
		('Windows Concentration Elective'),
		('Computer Elective'),
		('Database Management Option');

/************************************************************
***** Dependent Table Data (Join/Intersection Tables)	*****
************************************************************/

/************************************************************
***** 				Populate Major Table 				*****
************************************************************/
INSERT INTO Major (Code, Title, DegreeID)
VALUES 
		/* School of Computer Science */
		('0908','Advanced Network Infrastructure','6'),
		('0921','Cable Installation','6'),
		('2013','Computer Engineering Technology','1'),
		('2067','Computer Information Technology','1'),
		('0938','Computer Programming','6'),
		('2047','Computer Programming and Analysis (Software Engineering Technology)','1'),
		('2003','Electronics Engineering Technology','1'),
		('0902','Information Technology Administration','6'),
		('0903','Information Technology Analysis','6'),
		('0905','Information Technology Support Specialist','6'),
		('2005','Internet Services Technology','1'),
		('0907','Microcomputer Repairer/Installer','6'),
		('0923','Network Communications (LAN)','6'),
		('0924','Network Communications (WAN)','6'),
		('0922','Network Infrastructure','6'),
		('0904','Network Server Administration','6'),
		('0906','Network Support Technician','6'),
		('2002','Network Systems Technology','1'),
		('2204','Simulation and Robotics Technology','1'),
		('0909','Web Development Specialist','6'),
		('0925','Wireless Communications','6'),
		
		/* School of Engineering Technology */
		('3002','CyberSecurity and Cyberforensics','7'),
		('6331','Bachelor of Science in Engineering Technology (BSET)','3'),
		('6333','Bachelor of Science in Electrical Engineering Technology (BSEET)','3'),
		('6334','Bachelor of Science in Information Technology (BSIT)','3'),
		
		/* Associates of Arts Degree */
		('7000','Associates of Arts Degree','2'),
		('0100','General Studies','2');
		
/************************************************************
***** 			Populate MajorCategory Table 			*****
************************************************************/
INSERT INTO MajorCategory (CreditsRequired, ParentMajorCategoryID, MajorID, CategoryID)
VALUES /* (,,,),  */
		/***** Associates of Arts Degree - AA Degree *****/		
		/* 7000 - Associates of Arts Degree */
		/* General Education Courses */
		(60,NULL,27,2),
			/* General Education - Core */
		(36,1,27,4),
		(9,2,27,10),
		(6,2,27,11),
		(3,2,27,12),
		(3,2,27,13),
		(6,2,27,14),
		(3,2,27,15),
		(3,2,27,16),
		(3,2,27,17),
			/* General Education - Electives */
		(24,1,27,5),

		/***** School of Computer Science - AS Degree *****/
		/* 2013 - Computer Engineering Technology */
		/* General Education Courses */
		(18,NULL,3,2),
		(9,12,3,10),
		(3,12,3,11),
		(3,12,3,12),
		(3,12,3,13),
		/* Program Specific Courses */
		(50,NULL,3,3),
			/* Lower Level - Core */
		(40,17,3,6),
				/* Computer Programming Option */
		(3,18,3,18),		
			/* Lower Level - Electives */
		(10,17,3,7),
				
		/* 2067 - Computer Information Technology */
		/* General Education Courses */
		(15,NULL,4,2),
		(6,21,4,10),
		(3,21,4,11),
		(3,21,4,12),
		(3,21,4,13),
		/* Program Specific Courses */
		(48,NULL,4,3),
			/* Lower Level - Core */
		(40,26,4,6),
				/* Computer Programming Option */
		(3,27,4,18),		
			/* Lower Level - Electives */
		(8,26,4,7),
		
		/* 2047 - Computer Programming and Analysis (Software Engineering Technology) */
		/* General Education Courses */
		(15,NULL,6,2),
		(6,30,6,10),
		(3,30,6,11),
		(3,30,6,12),
		(3,30,6,13),
		/* Program Specific Courses */
		(48,NULL,6,3),
			/* Lower Level - Core */
		(39,35,6,6),
				/* Computer Programming Option */
		(3,36,6,18),		
			/* Lower Level - Electives */
		(9,35,6,7),
		
		/* 2003 - Electronics Engineering Technology */
		/* General Education Courses */
		(29,NULL,7,2),
		(9,39,7,10),
		(6,39,7,11),
		(3,39,7,12),
		(3,39,7,13),
		(8,39,7,14),
		(4,44,7,19),
		(4,44,7,20),
		
		/* Program Specific Courses */
		(39,NULL,7,3),
			/* Lower Level - Core */
		(35,45,7,6),
			/* Lower Level - Electives */
		(4,45,7,7),
		
		/* 2005 - Internet Services Technology */
		/* General Education Courses */
		(15,NULL,11,2),
		(6,47,11,10),
		(3,47,11,11),
		(3,47,11,12),
		(3,47,11,13),
		/* Program Specific Courses */
		(48,NULL,11,3),
			/* Lower Level - Core */
		(39,52,11,6),
				/* Database Management Option */
		(3,53,11,25),	
				/* Computer Programming Option */
		(3,53,11,18),		
			/* Lower Level - Electives */
		(9,52,11,7),
		
		/* 2002 - Network Systems Technology */
		/* General Education Courses */
		(15,NULL,18,2),
		(6,56,18,10),
		(3,56,18,11),
		(3,56,18,12),
		(3,56,18,13),
		/* Program Specific Courses */
		(48,NULL,11,3),
			/* Lower Level - Core */
		(33,61,18,6),
				/* Computer Programming Option */
		(3,62,18,18),		
			/* Lower Level - Electives */
		(15,61,18,7),
				/* Security Concentration Elective */
		(15,64,18,21),
					/* Computer Elective */
		(4,65,18,24),
				/* CISCO Concentration Elective */
		(15,64,18,22),
					/* Computer Elective */
		(3,65,18,24),
				/* Windows Concentration Elective */
		(15,64,18,23),
					/* Computer Elective */
		(3,65,18,24),
		
		/* 2204 - Simulation and Robotics Technology */
		/* General Education Courses */
		(15,NULL,19,2),
		(6,74,19,10),
		(3,74,19,11),
		(3,74,19,12),
		(3,74,19,13),
		/* Program Specific Courses */
		(53,NULL,19,3),
			/* Lower Level - Core */
		(53,79,19,6),
				/* Computer Programming Option */
		(3,80,19,18),
		
/*----------------------------------------------------------------------
	AS Certification MajorCategory data for Computer Science Programs
----------------------------------------------------------------------*/
		/* 0908 - Advanced Network Infrastructure */
		/* Program Specific Courses */
		(36,NULL,1,3),
		
		/* 0921 - Cable Installation */
		/* Program Specific Courses */
		(12,NULL,2,3),

		/* 0938 - Computer Programming */
		/* Program Specific Courses */
		(28,NULL,5,3),
			/* Computer Programming Option */
		(3,85,5,18),
				/* Database Management Option */
		(3,85,5,25),
				/* Computer Elective */
		(3,85,5,24),
		
		/* 0902 - Information Technology Administration */
		/* Program Specific Courses */
		(18,NULL,8,3),
		
		/* 0903 - Information Technology Analysis */
		/* Program Specific Courses */
		(27,NULL,9,3),
		
		/* 0905 - Information Technology Support Specialist */
		/* Program Specific Courses */
		(18,NULL,10,3),
		
		/* 0907 - Microcomputer Repairer/Installer */
		/* Program Specific Courses */
		(15,NULL,12,3),
		
		/* 0923 - Network Communications (LAN) */
		/* Program Specific Courses */
		(18,NULL,13,3),
		
		/* 0924 - Network Communications (WAN) */
		/* Program Specific Courses */
		(18,NULL,14,3),
		
		/* 0922 - Network Infrastructure */
		/* Program Specific Courses */
		(21,NULL,15,3),
		
		/* 0904 - Network Server Administration */
		/* Program Specific Courses */
		(24,NULL,16,3),
		
		/* 0906 - Network Support Technician */
		/* Program Specific Courses */
		(21,NULL,17,3),
		
		/* 0909 - Web Development Specialist */
		/* Program Specific Courses */
		(35,NULL,20,3),
		
		/* 0925 - Wireless Communications */
		/* Program Specific Courses */
		(18,NULL,21,3);

/************************************************************
***** 		Populate MajorCategoryCourse Table 			*****
************************************************************/
INSERT INTO MajorCategoryCourse (MajorCategoryID, CourseID)
VALUES /* (,,), */
		/* 2013 - Computer Engineering Technology */
		/* General Education Courses */
			/* Communication Core */
		(13,1),
		(13,2),
		(13,3),
			/* Mathematics Core */
		(14,5),
		(14,17),
			/* Behavioral & Social Sciences Core */
		(15,54),
		(15,55),
		(15,56),
			/* Humanities, Cultural & Aesthetic Core */
		(16,57),
		(16,58),
		(16,59),
		(16,60),
		(16,62),
		(16,64),
		(16,65),
		(16,67),
		(16,68),
		(16,70),
		(16,72),
		(16,73),
		(16,74),
		/* Program Specific Courses */
				/* Lower Level - Core */
		(18,105),
		(18,106),
		(18,107),
		(18,108),
		(18,109),
		(18,110),
		(18,117),
		(18,134),
		(18,170),
		(18,171),
		(18,172),
		(18,173),
		(18,174),
		(18,175),
		(18,176),
		(18,177),
		(18,184),
				/* Computer Programming Option */
		(19,135),
		(19,136),
		(19,137),
		(19,142),
			/* Lower Level - Electives */
		(20,99),
		(20,100),
		(20,111),
		(20,112),
		(20,115),
		(20,116),
		(20,122),
		(20,128),
		(20,149),
		(20,155),
		(20,158),
		(20,160),
		(20,186),
		(20,187),

		/* 2067 - Computer Information Technology */
		/* General Education Courses */
			/* Communication Core */
		(22,1),
		(22,3),
			/* Mathematics Core */
		(23,5),
		(23,17),
			/* Behavioral & Social Sciences Core */
		(24,54),
		(24,55),
		(24,56),
			/* Humanities, Cultural & Aesthetic Core */
		(25,57),
		(25,58),
		(25,59),
		(25,60),
		(25,62),
		(25,63),
		(25,64),
		(25,65),
		(25,66),
		(25,67),
		(25,68),
		(25,69),
		(25,70),		
		(25,71),
		(25,72),
		(25,73),
		(25,74),
			/* Program Specific Courses */
				/* Lower Level - Core */
		(27,107),
		(27,110),
		(27,122),
		(27,134),
		(27,141),
		(27,148),
		(27,149),
		(27,151),
		(27,155),
		(27,165),
		(27,166),
		(27,168),
		(27,169),
		(27,184),
				/* Computer Programming Option */
		(28,135),
		(28,136),
		(28,137),
		(28,142),
			/* Lower Level - Electives */
		(29,104),
		(29,123),
		(29,124),
		(29,128),
		(29,143),
		(29,144),
		(29,150),
		(29,159),
		(29,160),
		(29,163),

		/* 2047 - Computer Programming and Analysis (Software Engineering Technology) */
		/* General Education Courses */
			/* Communication Core */
		(31,1),
		(31,3),
			/* Mathematics Core */
		(32,5),
		(32,17),
			/* Behavioral & Social Sciences Core */
		(33,54),
		(33,55),
		(33,56),
			/* Humanities, Cultural & Aesthetic Core */
		(34,57),
		(34,58),
		(34,59),
		(34,60),
		(34,62),
		(34,63),
		(34,64),
		(34,65),
		(34,66),
		(34,67),
		(34,68),
		(34,69),
		(34,70),		
		(34,71),
		(34,72),
		(34,73),
		(34,74),
			/* Program Specific Courses */
				/* Lower Level - Core */
		(36,104),
		(36,107),
		(36,110),
		(36,134),
		(36,141),
		(36,142),
		(36,144),
		(36,148),
		(36,149),
		(36,151),
		(36,163),
		(36,165),
		(36,166),
		(36,184),
				/* Computer Programming Option */
		(37,135),
		(37,136),
		(37,137),
			/* Lower Level - Electives */
		(38,100),
		(38,115),
		(38,122),
		(38,124),
		(38,125),
		(38,143),
		(38,150),
		(38,159),
		(38,164),
		(38,169),

		/* 2003 - Electronics Engineering Technology */
		/* General Education Courses */
			/* Communication Core */
		(40,1),
		(40,2),
		(40,3),
			/* Mathematics Core */
		(41,5),
		(41,6),
		(41,17),
			/* Behavioral & Social Sciences Core */
		(42,54),
		(42,55),
		(42,56),
			/* Humanities, Cultural & Aesthetic Core */
		(43,57),
		(43,58),
		(43,59),
		(43,60),
		(43,62),
		(43,63),
		(43,64),
		(43,65),
		(43,66),
		(43,67),
		(43,68),
		(43,69),
		(43,70),		
		(43,72),
		(43,73),
		(43,74),
				/* Sciences (Biological & Physical) Core */
					/* Biological Science Core */
		(45,49),
		(45,50),
					/* Physical Science Core */
		(46,26),
		(46,27),
		(46,28),
		(46,33),
		(46,34),
			/* Program Specific Courses */
				/* Lower Level - Core */
		(48,105),
		(48,106),
		(48,108),
		(48,109),
		(48,122),
		(48,137),
		(48,170),
		(48,171),
		(48,172),
		(48,173),
		(48,174),
		(48,175),
		(48,176),
		(48,177),
		(48,178),
		(48,179),
		(48,180),
		(48,181),
			/* Lower Level - Electives */
		(49,260),
		(49,261),
		(49,149),
		(49,183),
		(49,184),

		/* 2005 - Internet Services Technology */
		/* General Education Courses */
			/* Communication Core */
		(51,1),
		(51,3),
			/* Mathematics Core */
		(52,5),
		(52,17),
			/* Behavioral & Social Sciences Core */
		(53,54),
		(53,55),
		(53,56),
			/* Humanities, Cultural & Aesthetic Core */
		(54,57),
		(54,58),
		(54,59),
		(54,60),
		(54,62),
		(54,63),
		(54,64),
		(54,65),
		(54,66),
		(54,67),
		(54,68),
		(54,69),
		(54,70),		
		(54,71),
		(54,72),
		(54,73),
		(54,74),
			/* Program Specific Courses */
				/* Lower Level - Core */
		(56,107),
		(56,110),
		(56,124),
		(56,125),
		(56,132),
		(56,134),
		(56,144),
		(56,145),
		(56,149),
		(56,169),
		(56,184),
				/* Database Management Option */
		(82,141),
		(82,165),
		(82,166),
				/* Computer Programming Option */
		(57,135),
		(57,136),
		(57,137),
		(57,142),
			/* Lower Level - Electives */
		(58,100),
		(58,104),
		(58,143),
		(58,150),
		(58,155),
		(58,159),
		(58,168),		
			
		/* 2002 - Network Systems Technology */
		/* General Education Courses */
			/* Communication Core */
		(60,1),
		(60,3),
			/* Mathematics Core */
		(61,5),
		(61,17),
			/* Behavioral & Social Sciences Core */
		(62,54),
		(62,55),
		(62,56),
			/* Humanities, Cultural & Aesthetic Core */
		(63,57),
		(63,58),
		(63,59),
		(63,60),
		(63,62),
		(63,63),
		(63,64),
		(63,65),
		(63,66),
		(63,67),
		(63,68),
		(63,69),
		(63,70),		
		(63,71),
		(63,72),
		(63,73),
		(63,74),
			/* Program Specific Courses */
				/* Lower Level - Core */
		(65,104),
		(65,107),
		(65,110),
		(65,134),
		(65,141),
		(65,142),
		(65,144),
		(65,148),
		(65,149),
		(65,151),
		(65,163),
		(65,165),
		(65,166),
		(65,184),
				/* Computer Programming Option */
		(66,135),
		(66,136),
		(66,137),
		(66,142),		
			/* Lower Level - Electives */
		(67,107),
		(67,110),
		(67,128),
		(67,130),
		(67,134),
		(67,155),
		(67,159),
		(67,162),
		(67,184),
				/* Security Concentration Elective */
		(68,126),
		(68,129),
		(68,133),
					/* Computer Elective */
		(69,113),
		(69,115),
		(69,116),
		(69,154),
		(69,157),
		(69,161),
		(69,176),
		(69,177),
				/* CISCO Concentration Elective */
		(70,111),
		(70,112),
		(70,114),
					/* Computer Elective */
		(71,113),
		(71,115),
		(71,116),
		(71,154),
		(71,157),
		(71,161),
		(71,176),
		(71,177),
				/* Windows Concentration Elective */
		(72,153),
		(72,158),
		(72,160),
					/* Computer Elective */
		(73,113),
		(73,115),
		(73,116),
		(73,154),
		(73,157),
		(73,161),
		(73,176),
		(73,177),		
		
		/* 2204 - Simulation and Robotics Technology */		
		/* General Education Courses */
			/* Communication Core */
		(75,1),
		(75,3),
			/* Mathematics Core */
		(76,5),
		(76,17),
			/* Behavioral & Social Sciences Core */
		(77,54),
		(77,55),
		(77,56),
			/* Humanities, Cultural & Aesthetic Core */
		(78,57),
		(78,58),
		(78,59),
		(78,60),
		(78,63),
		(78,64),
		(78,65),
		(78,67),
		(78,68),
		(78,70),
		(78,72),
		(78,73),
		(78,74),
			/* Program Specific Courses */
				/* Lower Level - Core */
		(80,99),
		(80,100),
		(80,103),
		(80,105),
		(80,106),
		(80,107),
		(80,110),
		(80,122),
		(80,134),
		(80,170),
		(80,171),
		(80,172),
		(80,173),
		(80,174),
		(80,175),
		(80,176),
		(80,177),
		(80,262),
		(80,263),
		(80,264),
		(80,265),
		(80,186),
		(80,187),
		(80,184),
				/* Computer Programming Option */
		(81,135),
		(81,136),
		(81,137),
		(81,142),

/*----------------------------------------------------------------------
AS Certification MajorCategoryCourse data for Computer Science Programs
----------------------------------------------------------------------*/
		/* 0908 - Advanced Network Infrastructure */
		/* Program Specific Courses */
		(83,107),
		(83,111),
		(83,112),
		(83,114),
		(83,116),
		(83,117),
		(83,128),
		(83,155),
		(83,159),
		(83,160),		
		
		/* 0921 - Cable Installation */
		/* Program Specific Courses */
		(84,170),
		(84,171),
		(84,172),
		(84,173),
		(84,176),
		(84,177),
		(84,184),

		/* 0938 - Computer Programming */
		/* Program Specific Courses */
		(85,104),
		(85,107),
		(85,110),
		(85,134),
		(85,142),
		(85,148),
		(85,163),
		(85,184),
			/* Computer Programming Option */
		(86,135),
		(86,136),
		(86,137),
			/* Database Management Option */
		(87,141),
		(87,165),
		(87,166),
			/* Computer Elective */
		(88,100),
		(88,122),
		(88,124),
		(88,125),
		(88,143),
		(88,144),
		(88,149),
		(88,150),
		
		/* 0902 - Information Technology Administration */
		/* Program Specific Courses */
		(89,110),
		(89,124),
		(89,125),
		(89,132),
		(89,134),
		(89,149),
		
		/* 0903 - Information Technology Analysis */
		/* Program Specific Courses */
		(90,107),
		(90,110),
		(90,122),
		(90,123),
		(90,132),
		(90,134),
		(90,168),
		(90,169),
		
		/* 0905 - Information Technology Support Specialist */
		/* Program Specific Courses */
		(91,107),
		(91,110),
		(91,122),
		(91,149),
		(91,155),
		
		/* 0907 - Microcomputer Repairer/Installer */
		/* Program Specific Courses */
		(92,107),
		(92,110),
		(92,155),
		(92,176),
		(92,177),
		
		/* 0923 - Network Communications (LAN) */
		/* Program Specific Courses */
		(93,107),
		(93,111),
		(93,112),
		(93,176),
		(93,177),
		(93,184),
		
		/* 0924 - Network Communications (WAN) */
		/* Program Specific Courses */
		(94,107),
		(94,111),
		(94,112),
		(94,134),
		(94,176),
		(94,177),
		
		/* 0922 - Network Infrastructure */
		/* Program Specific Courses */
		(95,107),
		(95,111),
		(95,112),
		(95,116),
		(95,128),
		(95,132),
		
		/* 0904 - Network Server Administration */
		/* Program Specific Courses */
		(96,107),
		(96,128),
		(96,132),
		(96,155),
		(96,158),
		(96,160),
		(96,184),
		
		/* 0906 - Network Support Technician */
		/* Program Specific Courses */
		(97,107),
		(97,110),
		(97,128),
		(97,155),
		(97,176),
		(97,177),
		(97,184),
		
		/* 0909 - Web Development Specialist */
		/* Program Specific Courses */
		(98,107),
		(98,110),
		(98,124),
		(98,125),
		(98,134),
		(98,144),
		(98,145),
		(98,149),
		(98,168),
		(98,169),
		(98,184),
		
		/* 0925 - Wireless Communications */
		/* Program Specific Courses */
		(99,107),
		(99,110),
		(99,116),
		(99,176),
		(99,177),
		(99,184);
		
/************************************************************
***** 			Populate StudentCourse Table 			*****
************************************************************/		
INSERT INTO StudentCourse (StudentID, CourseID)
VALUES /* (,,), */
		/* John Doe's Courses */
		(1,1),
		(1,3),
		(1,5),
		(1,55),
		(1,57),
		(1,107),
		(1,110),
		(1,134),
		(1,141),
		(1,142),
		(1,145),
		(1,149),
		(1,159),
		(1,165),
		(1,166),
		(1,169),		

		/* Jane Doe's Courses */		
		(2,1),
		(2,17),
		(2,19),
		(2,56),
		(2,110),
		(2,134),
		(2,141),
		(2,149),
		(2,151),
		(2,155),
		(2,159),
		(2,169);