---- START -- COPY -- & -- PASTE -- HERE ----

---- USER TABLE  --
-- added user access level
-- user defaults to level 2 (Group & Provider)
CREATE TABLE "user" (
	"id" SERIAL PRIMARY KEY,
	"username" varchar(25) NOT NULL UNIQUE,
	"password" varchar(500) NOT NULL,
	"access_level" int NOT NULL
);

---- GROUP TABLE ---- 
-- Add "NOT NULL" to columns laters. Allow NULL for testing
CREATE TABLE "group" (
	"id" serial PRIMARY KEY NOT NULL,
	"user_id" int REFERENCES "user"("id") ON DELETE CASCADE NOT NULL UNIQUE,
	"name" varchar(1000) NOT NULL DEFAULT 'My Name',
	"bio" varchar(1000) DEFAULT 'My Bio',
	"picture" varchar(1000) DEFAULT 
	'https://static.vecteezy.com/system/resources/thumbnails/007/319/936/small/user-profile-icon-vector.jpg',
	"website" varchar(1000) DEFAULT 'My Website',
	"email" varchar(1000) DEFAULT 'My email',
	"phone" varchar(50) DEFAULT 'My phone',
	"street" varchar(1000) DEFAULT 'My street',
	"city" varchar(1000) DEFAULT 'My city',
	"state" varchar(1000) DEFAULT 'My state',
	"zipcode" varchar(1000) DEFAULT 'My zipcode'
);


---- PROVIDER TABLE ----
-- Add "NOT NULL" to columns laters. Allow NULL for testing
CREATE TABLE "provider" (
	"id" serial PRIMARY KEY NOT NULL,
	"user_id" int REFERENCES "user"("id") ON DELETE CASCADE NOT NULL UNIQUE,
	"name" varchar(100) DEFAULT 'My Name',
	"bio" varchar(1000) DEFAULT 'My Bio',
	"picture" varchar(1000) DEFAULT 
	'https://static.vecteezy.com/system/resources/thumbnails/007/319/936/small/user-profile-icon-vector.jpg',
	"phone" varchar(50) DEFAULT 'My phone',
	"email" varchar(100) DEFAULT 'My email',
	"availability" varchar(1000) DEFAULT 'My Availability',
	"group_id" int 
);


---- specializations TABLE ----
CREATE TABLE "specializations" (
	"id" serial PRIMARY KEY  NOT NULL,
	"specialization" varchar(100)
);

---- insurance_plan TABLE ----
CREATE TABLE "insurance_plan" (
	"id" serial PRIMARY KEY NOT NULL,
	"insurance" varchar(100)
);

---- service_type TABLE ----
CREATE TABLE "service_type" (
	"id" serial PRIMARY KEY NOT NULL,
	"service" varchar(255) 
);
---- occupations TABLE ----
CREATE TABLE "occupations" (
	"id" serial PRIMARY KEY NOT NULL,
	"occupation" varchar(255) 
);

---- Availability Table -- Not using anymore
--CREATE TABLE "availability" (
--	"id" serial PRIMARY KEY NOT NULL,
--	"availability" varchar(255) 
--);


------------- CREATE JUNCTION TABLES --------------------
---- specializations JUNCTION TABLE ----
CREATE TABLE "provider_specializations" (
	"id" serial PRIMARY KEY NOT NULL,
	"provider_id" int REFERENCES "provider"("id") ON DELETE CASCADE NOT NULL,
	"specializations_id" int REFERENCES "specializations"("id") NOT NULL
);

---- insurance_plan JUNCTION TABLE ----
CREATE TABLE "provider_insurance_plan" (
	"id" serial PRIMARY KEY NOT NULL,
	"provider_id" int REFERENCES "provider"("id") ON DELETE CASCADE NOT NULL,
	"insurance_plan_id" int REFERENCES "insurance_plan"("id") NOT NULL
);

---- service_type JUNCTION TABLE ----
CREATE TABLE "provider_service_type" (
	"id" serial PRIMARY KEY NOT NULL,
	"provider_id" int REFERENCES "provider"("id") ON DELETE CASCADE NOT NULL,
	"service_type_id" int REFERENCES "service_type"("id") NOT NULL
);

---- provider_occupation JUNCTION TABLE ----
CREATE TABLE "provider_occupation" (
	"id" serial PRIMARY KEY NOT NULL,
	"provider_id" int REFERENCES "provider"("id") ON DELETE CASCADE NOT NULL,
	"occupation_id" int REFERENCES "occupations"("id") NOT NULL
);

---- availability JUNCTION TABLE -- Not using anymore
-- CREATE TABLE "provider_availability" (
-- 	"id" serial PRIMARY KEY NOT NULL,
-- 	"provider_id" int REFERENCES "provider"("id") NOT NULL,
-- 	"availability_id" int REFERENCES "availability"("id") NOT NULL
-- );


------------------ ACTUAL DATA ------------------
---- INSERT specializations TABLE ----
INSERT INTO "specializations" ("specialization") VALUES
('LGBTQ Specific'),
('POC Specific'),
('Disability Specific'),
('Addiction'),
('Anxiety'),
('ADHD'),
('Autism'),
('Bipolar'),
('Child Psychiatry'),
('Cognitive-behavioral therapy'),
('COVID-related'),
('HOH'),
('Depression'),
('Crisis Response'),
('Eating Disorders'),
('Grief'),
('Group Therapy'),
('Family Counseling'),
('Medication Management'),
('OCD'),
('PTSD'),
('Diagnosis');

---- INSERT insurance_plan TABLE ----
INSERT INTO "insurance_plan" ("insurance") VALUES
('Blue Cross and Blue Shield of Minnesota'),
('HealthPartners'),
('Medica of Minnesota'),
('Quartz'),
('PreferredOne Insurance Company'),
('Golden Rule Insurance Company'),
('Independence American Insurance Company'),
('Ucare'),
('Humana'),
('Cigna'),
('Silverscript'),
('Medicare Insurance Providers in Minnesota');

---- INSERT service_type TABLE ----
INSERT INTO "service_type" ("service") VALUES
('Online'),
('In-Person'),
('Over the Phone'),
('Inpatient'),
('Outpatient');

---- INSERT occupation TABLE ----
INSERT INTO "occupations" ("occupation") VALUES
('Psychologist'),
('Counselor'),
('Certified Alcohol and Drug Abuse Counselor'),
('Clinician'),
('Clinical Social Worker'),
('Psychiatrist'),
('Mental Health Nurse Practitioner'),
('Family Nurse Practitioner'),
('Peer Specialist');

---- INSERT availability TABLE -- Not using anymore
--INSERT INTO "availability" ("availability") VALUES
--('My office is open Monday through Friday'),
--('My office offers evening and weekend appointments'),
--('Please contact me for appointment availability');

-- DUMMY DATA --   
--  USER Dummy Data --
INSERT INTO "user" ( "username", "password", "access_level") VALUES 
( 'admin', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 1),  --user 1
( 'group1', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 3), --user 2
( 'group2', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 3), --user 3
( 'user2', '$2a$10$SQmJWHmEcIjZHeHAx7/0JOTl2VthYS2PJAfIJ0jyjUh8zuhsCefzC', 3), --user 4 -- password is 'password'
( 'group4', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 3), --user 5
( 'group5', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 3), --user 6
( 'group6', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 3), --user 7
( 'group7', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 3), --user 8
( 'group8', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 3), --user 9
( 'group9', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 3), --user 10
( 'group10', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 3), --user 11
( 'provider1', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 2),  --user 12
( 'provider2', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 2), --user 13
( 'provider3', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 2), --user 14
( 'provider4', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 2), --user 15
( 'provider5', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 2), --user 16
( 'provider6', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 2), --user 17
( 'provider7', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 2), --user 18
( 'provider8', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 2), --user 19
( 'provider9', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 2), --user 20
( 'user1', '$2a$10$SQmJWHmEcIjZHeHAx7/0JOTl2VthYS2PJAfIJ0jyjUh8zuhsCefzC', 2)	 --user 21 -- password is 'password'
;

--  GROUP Dummy Data --
INSERT INTO "group" ( "user_id", "name", "bio", "website", "email", "phone", "street", "city", "state", "zipcode") VALUES 
(2, -- user_id
'Mayo Family Clinic Northwest', 
'Community Pediatric and Adolescent Medicine - Offers primary care services to infants, children and adolescents through college. 
Family Medicine - is available to people of all ages; provides family-oriented comprehensive care, including obstetrical care and well-woman care, newborn and well-child care, pediatrics and adult/geriatric care. 
Community Internal Medicine - serves individuals 18 years of age or older for all aspects of adult health.', -- BIO
'https://communityhealth.mayoclinic.org/locations/northwest-clinic', --website
'MayoFamily@gmail.com', 
'507-538-8555', --phone
'4111 West Frontage Road, Hwy 52 NW', --street
'Rochester',  --city
'MN', --state
'55901'), --zipcode
(3, -- user_id
'Rochester Family Clinic', 
'Rochester Family Clinic - Offers primary care services to infants, children and adolescents through college and is available to people of all ages.', -- BIO
'https://communityhealth.mayoclinic.org/locations/northwest-clinic', 
'RochesterFamilyClinic@gmail.com', 
'507-832-8555', 
'3152 Frontage Road', 
'Rochester', 
'MN', 
'55901'),
(4, -- user_id
'Example Clinic (Group)', 
'Example Clinic - Offers primary care services to infants, children and adolescents through college and is available to people of all ages.', -- BIO
'https://communityhealth.mayoclinic.org/locations/northwest-clinic', 
'RochesterFamilyClinic@gmail.com', 
'507-832-8555', 
'3152 Frontage Road', 
'Rochester', 
'MN', 
'55901');


--  PROVIDER Dummy Data --
INSERT INTO "provider" ( "user_id", "name", "bio", "picture","phone", "email", "availability", "group_id") VALUES
(12, 
'Dr. Carla Espinosa, M.D.', 
'Community Internal Medicine, Geriatrics and Palliative Care',
 'https://communityhealth.mayoclinic.org/-/media/staff/taylorcammack30082321.jpg?sc_lang=en&la=en&hash=7A74380D17A29047A30F823A254F918B', 
 '507-832-8554', 'Espinosa@gmail.com', 
 'M-F, 8am to 5pm', 
 1),
 (13, 
'Dr. Christopher Turk, M.D.', 
'Community Pediatric and Adolescent Medicine',
 'https://communityhealth.mayoclinic.org/-/media/staff/freddavis30188707.jpg?sc_lang=en&la=en&hash=EB8B0262109E5C86B94E7B52F4736AA0', 
 '507-832-8554', 'Christopher@gmail.com', 
 'M-F, 8am to 5pm', 
 1),
  (14, 
'Dr. Elliot Reid M.D.', 
'Community Internal Medicine, Geriatrics and Palliative Care',
 'https://communityhealth.mayoclinic.org/-/media/staff/taylorcammack30082321.jpg?sc_lang=en&la=en&hash=7A74380D17A29047A30F823A254F918B', 
 '507-832-8551', 'Reid@gmail.com', 
 'M-F, 8am to 5pm', 
 1),
 (15, 
'Dr. John Dorian, M.D.', 
'Community Pediatric and Adolescent Medicine',
 'https://communityhealth.mayoclinic.org/-/media/staff/jacobbillings16232925.jpg?sc_lang=en&la=en&hash=B7230957910C81A36FFECF53CD0CA719', 
 '507-832-8552', 'Dorian@gmail.com', 
 'M-F, 8am to 5pm', 
 1),

  (16, 
'Dr. Kim Briggs, M.B.B.S.', 
'Community Internal Medicine, Geriatrics and Palliative Care',
 'https://communityhealth.mayoclinic.org/-/media/staff/asmaali21308675.jpg?la=en&hash=1A2F054DF00651B6DAAC3F5BD8294EF3', 
 '507-832-8552', 'Briggs@gmail.com', 
 'M-F, 8am to 5pm', 
 1),
  (17, 
'Dr. Molly Clock, M.D.', 
'Family Medicine',
 'https://communityhealth.mayoclinic.org/-/media/staff/hopebrus30188712.jpg?sc_lang=en&la=en&hash=4AEAEEECEB6B090A5058D680C2CF6937', 
 '507-832-8553', 'Clock@gmail.com', 
 'M-F, 8am to 5pm', 
 1),
   (18, 
'Dr. Nan Roberts, M.D.', 
'Community Pediatric and Adolescent Medicine',
 'https://communityhealth.mayoclinic.org/-/media/staff/badroali30082325.jpg?la=en&hash=39E337E230F43FE63363E6CA51644DF5', 
 '507-832-8553', 'Roberts@gmail.com', 
 'M-F, 8am to 5pm', 
 1),
   (19, 
'Dr. Nate Notermann, M.D.', 
'Community Internal Medicine, Geriatrics and Palliative Care',
 'https://avatars.githubusercontent.com/u/98718660?v=4', 
 '507-832-8553', 'note@gmail.com', 
 'M-F, 8am to 5pm', 
 1),
   (20, 
'Dr. Perry Cox, M.D.', 
'Family Medicine',
 'https://communityhealth.mayoclinic.org/-/media/staff/aldoacostamedina21318280.jpg?la=en&hash=FF67279A31B6DD84475ED17A985F8BC6', 
 '507-832-8553', 'Cox@gmail.com', 
 'M-F, 8am to 5pm', 
 1),
   (21, 
'John Smith M.D.', 
'I am an example provider.',
 'https://static.vecteezy.com/system/resources/thumbnails/007/319/936/small/user-profile-icon-vector.jpg', 
 '507-832-8543', 'Smith@gmail.com', 
 'M-F, 8am to 5pm', 
 1)
 ;


-- provider_specializations JUNCTION TABLE DUMMY DATA --  
INSERT INTO "provider_specializations" ( "provider_id", "specializations_id") VALUES 
( 1, 1), -- LGBTQ
( 2, 2), -- POC Specific
( 2, 4), 
( 3, 3), -- Disability Specific
( 4, 1), -- LGBTQ
( 4, 2), -- POC Specific
( 4, 3), -- Disability Specific
( 4, 4),
( 5, 5),
( 5, 3),
( 6, 1),
( 6, 6),
( 7, 2),
( 7, 7),
( 8, 9),
( 8, 8),
( 8, 10),
( 9, 4),
( 10, 11),
( 10, 2),
( 10, 6),
( 10, 2)
;


-- provider_specializations JUNCTION TABLE DUMMY DATA --  
INSERT INTO "provider_insurance_plan" ( "provider_id", "insurance_plan_id") VALUES 
( 1, 1), -- Blue Cross and Blue Shield of Minnesota
( 2, 2), -- HealthPartners
( 3, 3), -- Medica of Minnesota
( 4, 1), -- Blue Cross and Blue Shield of Minnesota
( 4, 2), -- HealthPartners
( 4, 3), -- Medica of Minnesota
( 5, 4),
( 5, 6),
( 7, 7),
( 8, 8),
( 9, 9),
( 10, 4),
( 10, 1)
; 


-- provider_service_type JUNCTION TABLE DUMMY DATA --  
INSERT INTO "provider_service_type" ( "provider_id", "service_type_id") VALUES 
( 1, 1), -- Online
( 2, 2), -- InPerson
( 3, 3), -- Over the Phone
( 4, 1), -- Online
( 4, 2), -- InPerson
( 4, 3), -- Over the Phone
( 4, 4),
( 5, 4),
( 5, 5),
( 7, 3),
( 8, 2),
( 9, 1),
( 10, 5),
( 10, 1); -- Inpatient


INSERT INTO "provider_occupation" ( "provider_id", "occupation_id") VALUES 
(1, 1), -- Psychologist
(2, 2), -- Counselor
(3, 3), -- Certified Alcohol and Drug Abuse Counselor
(4, 1), -- Psychologist
(4, 2), -- Counselor
(4, 3), -- Certified Alcohol and Drug Abuse Counselor
(4, 4),
( 5, 4),
( 5, 6),
( 7, 7),
( 8, 8),
( 9, 9),
( 10, 4),
( 10, 1); -- Clinician

--------------------- STOP -- COPY -- & -- PASTE -- HERE ---------------------
