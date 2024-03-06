
----------------------------- DELETE PROVIDER & GROUP ---------------------------------------
---- Code to TEST the different DELETE ----
-- DELETE FROM "user" WHERE "id" = 13;
-- DELETE FROM "provider" WHERE "id" = 3;
-- DELETE FROM "group" WHERE "id" = 3;
--------------------------------------------------------------------------------------- 

--------------------- GET/SELECTS for PROVIDER/GROUP LIST & DROP DOWNS ---------------------

---- GET ALL  ---- 
SELECT * FROM "user"; -- GET ALL USERS

SELECT * FROM "group"  -- GET ALL GROUPS - alphabetically
ORDER BY "group";

SELECT * FROM "provider" -- GET ALL PROVIDERS - alphabetically
ORDER BY "provider"; 

SELECT * FROM "specializations" -- GET ALL specializations - alphabetically
ORDER BY "specialization"; 

SELECT * FROM "insurance_plan" -- GET ALL insurance_plan - alphabetically
ORDER BY "insurance"; 

SELECT * FROM "service_type"  -- GET ALL service_type
ORDER BY "id";

SELECT * FROM "occupations" -- GET ALL occupations - alphabetically
ORDER BY "occupation";
---------------------------------------------------------------



 --------------------- PROVIDER/GROUP DETIALS Page(s) ---------------- 
---- GET ONE BY ID ---- 
SELECT * FROM "user" WHERE "user"."id" = 1; -- GET ONE USER BY "id" example: 1
SELECT * FROM "group" WHERE "group"."id" = 1; -- GET ONE GROUP BY "id" example: 1
SELECT * FROM "provider" WHERE "provider"."id" = 1; -- GET ONE PROVIDER BY "id" example: 1
SELECT * FROM "provider" WHERE "provider"."id" = 1; -- GET ONE PROVIDER BY "id" example: 1

--GET ONE GROUP BY USER.ID, example: 2
SELECT * FROM "group" 
JOIN "user" ON "group"."user_id" = "user"."id" WHERE "user"."id" = 2;

--GET ONE PROVIDER BY USER.ID, example: 3
SELECT * FROM "provider" 
JOIN "user" ON "provider"."user_id" = "user"."id" WHERE "user"."id" = 4;

-- GET PROVIDER INSURANCE BY PROVIDER.ID -- 
SELECT insurance_plan.insurance FROM insurance_plan
JOIN provider_insurance_plan
ON provider_insurance_plan.insurance_plan_id = insurance_plan.id
WHERE provider_insurance_plan.provider_id = 1;

-- GET PROVIDER service_type BY PROVIDER.ID -- 
SELECT service_type.service FROM service_type
JOIN provider_service_type 
ON provider_service_type.service_type_id = service_type.id
WHERE provider_service_type.provider_id = 1;

-- GET PROVIDER specializations BY PROVIDER.ID --
SELECT "specializations"."specialization" FROM "specializations"
JOIN "provider_specializations"
ON "provider_specializations"."specializations_id" = "specializations"."id"
WHERE "provider_specializations"."provider_id" = 1;

-- GET PROVIDER occupations BY PROVIDER.ID --
SELECT "occupations"."occupation" FROM "occupations"
JOIN "provider_occupation"
ON "provider_occupation"."occupation_id" = "occupations"."id"
WHERE "provider_occupation"."provider_id" = 1;

-- SEARCH ALL Providers by NAME -- Ascending and Descending
SELECT * FROM "provider" WHERE "name" ILIKE '%rovid%' ORDER BY "provider"."name" ASC;
SELECT * FROM "provider" WHERE "name" ILIKE '%rovid%' ORDER BY "provider"."name" DESC;

-- SEARCH ALL Groups by NAME -- Ascending and Descending
SELECT * FROM "group" WHERE "name" ILIKE '%group%' ORDER BY "group"."name" ASC;
SELECT * FROM "group" WHERE "name" ILIKE '%group%' ORDER BY "group"."name" DESC;
---------------------



-----------------------------FILTER/SEARCH VIEWS ---------------------------------------
---------------- SEARCH by ONE thing ---------------- 
-- FILTER/SEARCH  Providers by 1 SPECIALIZATION -- 
SELECT "provider"."id", "provider"."name", "provider"."picture", "provider"."phone", "provider"."email" FROM "provider" 
JOIN "provider_specializations" 
ON "provider"."id" = "provider_specializations"."provider_id"
JOIN "specializations"
ON "specializations"."id" = "provider_specializations"."id"
WHERE "specializations"."specialization" ILIKE '%POC Specific%' 
ORDER BY "provider"."name";

-- FILTER/SEARCH  Providers by 1 OCCUPATION -- 
SELECT "provider"."id", "provider"."name", "provider"."picture", "provider"."phone", "provider"."email" FROM "provider" 
JOIN "provider_occupation" 
ON "provider"."id" = "provider_occupation"."provider_id"
JOIN "occupations"
ON "occupations"."id" = "provider_occupation"."id"
WHERE "occupations"."occupation" ILIKE '%counselor%' 
ORDER BY "provider"."name";

-- FILTER/SEARCH  Providers by 1 SERVICE_TYPE -- 
SELECT "provider"."id", "provider"."name", "provider"."picture", "provider"."phone", "provider"."email", "service_type"."service" FROM "provider" 
JOIN "provider_service_type" 
ON "provider"."id" = "provider_service_type"."provider_id"
JOIN "service_type"
ON "service_type"."id" = "provider_service_type"."id"
WHERE "service_type"."service" ILIKE '%out%' 
ORDER BY "provider"."name";

-- FILTER/SEARCH  Providers by 1 INSURANCE -- 
SELECT "provider"."id", "provider"."name", "provider"."picture", "provider"."phone", "provider"."email" FROM "provider" 
JOIN "provider_insurance_plan" 
ON "provider"."id" = "provider_insurance_plan"."provider_id"
JOIN "insurance_plan"
ON "insurance_plan"."id" = "provider_insurance_plan"."id"
WHERE "insurance_plan"."insurance" ILIKE '%blue%' 
ORDER BY "provider"."name";



---------------- FILTER/SEARCH By MULTIPLE Things using ARRAY_AGG ----------------
--searches multiple filters insurance_plan
SELECT provider.name, array_agg(insurance_plan.insurance) as "accepted insurances" FROM provider
JOIN provider_insurance_plan ON provider_insurance_plan.provider_id = provider.id
JOIN insurance_plan ON insurance_plan.id = provider_insurance_plan.insurance_plan_id
where insurance_plan.insurance ilike '%health%'
or insurance_plan.insurance ilike ''
GROUP BY provider.name
order by provider.name asc;

--searches multiple filters specializations
SELECT provider.name, provider.picture, array_agg(specializations.specialization) as "specialties" FROM provider
JOIN provider_specializations ON provider_specializations.provider_id = provider.id
JOIN specializations ON specializations.id = provider_specializations.specializations_id
group by provider.name, provider.picture
order by provider.name asc;

--search multiple filters specializations
SELECT provider.name, array_agg(specializations.specialization) as "specializations" FROM provider
JOIN provider_specializations ON provider_specializations.provider_id = provider.id
JOIN specializations ON specializations.id = provider_specializations.specializations_id
where specializations.specialization ilike '%l%'
group by provider.name
order by provider.name asc;

--search multiple filters occcupation
SELECT provider.name, array_agg(occupations.occupation) as "Occupation" FROM provider
JOIN provider_occupation ON provider_occupation.provider_id = provider.id
JOIN occupations ON occupations.id = provider_occupation.occupation_id
group by provider.name
order by provider.name asc;
------------------------------------------------------------------------------------------



---------------- FILTER/SEARCH By MULTIPLE Things by NAME----------------
---------------- NO CURRENTLY BEING IMPLEMENTED ----------------
-- FILTER/SEARCH  Providers by MULITPLE Insurance -- (12 posible selections)
SELECT *
FROM "provider" 
JOIN "provider_insurance_plan" 
ON "provider"."id" = "provider_insurance_plan"."provider_id"
JOIN "insurance_plan"
ON "insurance_plan"."id" = "provider_insurance_plan"."insurance_plan_id"
WHERE "insurance_plan"."insurance" ILIKE '%medica%' 
OR "insurance_plan"."insurance" ILIKE '%health%'
OR "insurance_plan"."insurance" ILIKE '%quartz%'
OR "insurance_plan"."insurance" ILIKE ''
OR "insurance_plan"."insurance" ILIKE ''
OR "insurance_plan"."insurance" ILIKE ''
OR "insurance_plan"."insurance" ILIKE ''
OR "insurance_plan"."insurance" ILIKE ''
OR "insurance_plan"."insurance" ILIKE ''
OR "insurance_plan"."insurance" ILIKE ''
OR "insurance_plan"."insurance" ILIKE ''
OR "insurance_plan"."insurance" ILIKE ''
ORDER BY "provider"."name";


-- GET ALL Providers and their INSURANCE, -- THIS DOUBLE CHECKS the above SEARCH by MULITPLE Insurance
SELECT "provider"."name", "insurance_plan"."id", "insurance_plan"."insurance" FROM "provider" 
JOIN "provider_insurance_plan" 
ON "provider"."id" = "provider_insurance_plan"."provider_id"
JOIN "insurance_plan"
ON "insurance_plan"."id" = "provider_insurance_plan"."insurance_plan_id"
ORDER BY "provider"."name";

-- FILTER/SEARCH  Providers by MULITPLE specialization -- (22 posible selections)
SELECT *
FROM "provider" 
JOIN "provider_specializations" 
ON "provider"."id" = "provider_specializations"."provider_id"
JOIN "specializations"
ON "specializations"."id" = "provider_specializations"."specializations_id"
WHERE "specializations"."specialization" ILIKE '%ADH%' 
OR "specializations"."specialization" ILIKE '%LGBT%'
OR "specializations"."specialization" ILIKE '%COVID%'
OR "specializations"."specialization" ILIKE '%OCD%'
OR "specializations"."specialization" ILIKE ''
OR "specializations"."specialization" ILIKE ''
OR "specializations"."specialization" ILIKE ''
OR "specializations"."specialization" ILIKE ''
OR "specializations"."specialization" ILIKE ''
OR "specializations"."specialization" ILIKE ''
OR "specializations"."specialization" ILIKE ''
OR "specializations"."specialization" ILIKE ''
OR "specializations"."specialization" ILIKE ''
OR "specializations"."specialization" ILIKE ''
OR "specializations"."specialization" ILIKE ''
OR "specializations"."specialization" ILIKE ''
OR "specializations"."specialization" ILIKE ''
OR "specializations"."specialization" ILIKE ''
OR "specializations"."specialization" ILIKE ''
OR "specializations"."specialization" ILIKE ''
OR "specializations"."specialization" ILIKE ''
OR "specializations"."specialization" ILIKE ''
ORDER BY "provider"."name" ASC;


-- FILTER/SEARCH  Providers by MULITPLE specialization -- (5 posible selections)
SELECT * FROM "provider" 
JOIN "provider_service_type" 
ON "provider"."id" = "provider_service_type"."provider_id"
JOIN "service_type"
ON "service_type"."id" = "provider_service_type"."id"
WHERE "service_type"."service" ILIKE '%online%' 
OR "service_type"."service" ILIKE '%phone%' 
OR "service_type"."service" ILIKE ''
OR "service_type"."service" ILIKE '' 
OR "service_type"."service" ILIKE ''  
ORDER BY "provider"."name";


-- FILTER/SEARCH  Providers by MULITPLE occupation -- (9 posible selections)
SELECT * FROM "provider" 
JOIN "provider_occupation" 
ON "provider"."id" = "provider_occupation"."provider_id"
JOIN "occupations"
ON "occupations"."id" = "provider_occupation"."id"
WHERE "occupations"."occupation" ILIKE '%Psychologist%' 
OR "occupations"."occupation" ILIKE '%counselor%'
OR "occupations"."occupation" ILIKE '' 
OR "occupations"."occupation" ILIKE '' 
OR "occupations"."occupation" ILIKE '' 
OR "occupations"."occupation" ILIKE '' 
OR "occupations"."occupation" ILIKE '' 
OR "occupations"."occupation" ILIKE '' 
OR "occupations"."occupation" ILIKE '' 
ORDER BY "provider"."name";
------------------------------------------------------------------------------------------

--Profile provider get

    SELECT "provider"."id", "user_id", "name", "bio", "picture", "phone", "email", "availability", "access_level" FROM "provider" 
  JOIN "user" ON "provider"."user_id" = "user"."id" WHERE "user_id" = 21;
-----------------------------EDIT/UPDATE VIEWS ONLY---------------------------------------
-- UPDATE - PROVIDER info by "Provider.id"
    UPDATE "provider" SET ("name", "bio", "phone", "email", "availability")  =  ('isaac', 'updated', '55555', 'updated email', 'updatttteeed') WHERE "id" = 13;
-- UPDATE - GROUP info by "Provider.user_ID"
UPDATE "group" SET "name" = 'updated db name' WHERE "group"."user_id" = 2;
UPDATE "group" SET "bio" = 'updated db bio' WHERE "group"."user_id" = 2;
UPDATE "group" SET "website" = 'updated db website' WHERE "group"."user_id" = 2;
UPDATE "group" SET "email" = 'updated db email' WHERE "group"."user_id" = 2;
UPDATE "group" SET "phone" = 'updated db phone' WHERE "group"."user_id" = 2;
UPDATE "group" SET "street" = 'updated db email' WHERE "group"."user_id" = 2;
UPDATE "group" SET "city" = 'updated db city' WHERE "group"."user_id" = 2;
UPDATE "group" SET "state" = 'updated db phone' WHERE "group"."user_id" = 2;
UPDATE "group" SET "zipcode" = 'updated db zipcode' WHERE "group"."user_id" = 2;

---------------------------------------------------------------------------------------------

---- THIS GETS EVERYTHING. Does't really work. Mostly here so anyone can test different JOINS ----
-- GET INSURANCE,service_type & specializations for ONE provider by provider.id --
SELECT  "provider"."name", "provider"."bio", "provider"."email", "provider"."name", "specializations"."specialization", "service_type"."service", "insurance_plan"."insurance" FROM "specializations"
JOIN "provider_specializations"
ON "provider_specializations"."specializations_id" = "specializations"."id"
JOIN "provider"
ON "provider"."id" = "provider_specializations"."provider_id"
JOIN "provider_insurance_plan" 
ON "provider_insurance_plan"."provider_id" = "provider"."id"
JOIN "insurance_plan"
ON "insurance_plan"."id" = "provider_insurance_plan"."insurance_plan_id"
JOIN "provider_service_type" 
ON "provider_service_type"."provider_id" = "provider"."id"
JOIN "service_type"
ON "service_type"."id" = "provider_service_type"."provider_id"
WHERE "provider"."id" = 1;


--------------------------------------------------------PROFILE VIEWS ONLY---------------------------------------------------------------------

--PROFILE VIEW: insurance by user_id
SELECT insurance_plan.insurance FROM insurance_plan
JOIN provider_insurance_plan ON provider_insurance_plan.insurance_plan_id = insurance_plan.id
JOIN provider ON provider.id = provider_insurance_plan.provider_id
WHERE provider.user_id = 7;

--PROFILE VIEW: occupation by user_id
SELECT occupations.occupation FROM occupations
JOIN provider_occupation ON provider_occupation.occupation_id = occupations.id
JOIN provider ON provider.id = provider_occupation.provider_id
WHERE provider.user_id = 7;

--PROFILE VIEW: specialities by user_id
SELECT specializations.specialization FROM specializations
JOIN provider_specializations ON provider_specializations.specializations_id = specializations.id
JOIN provider ON provider.id = provider_specializations.provider_id
WHERE provider.user_id = 7;

--PROFILE VIEW: services by user_id
SELECT service_type.service FROM service_type
JOIN provider_service_type ON provider_service_type.service_type_id = service_type.id
JOIN provider ON provider.id = provider_service_type.provider_id
WHERE provider.user_id = 7;
-----------------------------------------------------------------------------------------------------------------------------


-----! DELETE/DROP TABLES !-----
-- DROP TABLE "provider_specializations";
-- DROP TABLE "provider_insurance_plan";
-- DROP TABLE "provider_service_type";
-- DROP TABLE "provider_occupation";
-- DROP TABLE "specializations";
-- DROP TABLE "insurance_plan";
-- DROP TABLE "service_type";
-- DROP TABLE "occupations";
-- DROP TABLE "provider";
-- DROP TABLE "group";
-- DROP TABLE "user";
-----! DELETE/DROP TABLES !-----

SELECT "provider"."id", "provider"."name", "provider"."picture", "provider"."phone", "provider"."email", "specializations"."specialization"
 FROM "provider" 
JOIN "provider_specializations" 
ON "provider"."id" = "provider_specializations"."provider_id"
JOIN "specializations"
ON "specializations"."id" = "provider_specializations"."specializations_id"
WHERE "specializations"."specialization" ILIKE '%an%' 
ORDER BY "provider"."name";