--------------------------------------------------------
--  File created - Segunda-feira-Janeiro-15-2018   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table DATAFILE
--------------------------------------------------------

  CREATE TABLE "MANAGER"."DATAFILE" 
   (	"NAME_DF" VARCHAR2(40 BYTE), 
	"NAME_TB" VARCHAR2(40 BYTE), 
	"FILE_SIZE" NUMBER, 
	"USED_SIZE" NUMBER, 
	"FREE_SIZE" NUMBER, 
	"TIMESTAMP" TIMESTAMP (6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TP_TABLES" ;
--------------------------------------------------------
--  DDL for Table IO
--------------------------------------------------------

  CREATE TABLE "MANAGER"."IO" 
   (	"TIMESTAMP" TIMESTAMP (6), 
	"WRITES" FLOAT(126), 
	"READS" FLOAT(126), 
	"FREE_MEMORY" FLOAT(126)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "TP_TABLES" ;
--------------------------------------------------------
--  DDL for Table SESSIONS
--------------------------------------------------------

  CREATE TABLE "MANAGER"."SESSIONS" 
   (	"SID" VARCHAR2(20 BYTE), 
	"USER_ID" VARCHAR2(20 BYTE), 
	"USERNAME" VARCHAR2(20 BYTE), 
	"SERIAL" VARCHAR2(20 BYTE), 
	"TIMESTAMP" TIMESTAMP (6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TP_TABLES" ;
--------------------------------------------------------
--  DDL for Table TABLESPACE
--------------------------------------------------------

  CREATE TABLE "MANAGER"."TABLESPACE" 
   (	"NAME" VARCHAR2(40 BYTE), 
	"USED_SIZE" NUMBER, 
	"FREE_SIZE" NUMBER, 
	"TOTAL_SIZE" NUMBER, 
	"TIMESTAMP" TIMESTAMP (6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TP_TABLES" ;
--------------------------------------------------------
--  DDL for Table USERS
--------------------------------------------------------

  CREATE TABLE "MANAGER"."USERS" 
   (	"USER_ID" NUMBER, 
	"USERNAME" VARCHAR2(40 BYTE), 
	"ACCOUNT_STATUS" VARCHAR2(20 BYTE), 
	"DEFAULT_TB" VARCHAR2(40 BYTE), 
	"TEMP_TB" VARCHAR2(40 BYTE), 
	"CREATED" DATE, 
	"TIMESTAMP" TIMESTAMP (6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TP_TABLES" ;
REM INSERTING into MANAGER.DATAFILE
SET DEFINE OFF;
REM INSERTING into MANAGER.IO
SET DEFINE OFF;
REM INSERTING into MANAGER.SESSIONS
SET DEFINE OFF;
REM INSERTING into MANAGER.TABLESPACE
SET DEFINE OFF;
REM INSERTING into MANAGER.USERS
SET DEFINE OFF;
--------------------------------------------------------
--  DDL for Index DATAFILE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "MANAGER"."DATAFILE_PK" ON "MANAGER"."DATAFILE" ("NAME_DF", "TIMESTAMP") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TP_TABLES" ;
--------------------------------------------------------
--  DDL for Index SESSIONS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "MANAGER"."SESSIONS_PK" ON "MANAGER"."SESSIONS" ("SID", "TIMESTAMP") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TP_TABLES" ;
--------------------------------------------------------
--  DDL for Index SYSTEM_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "MANAGER"."SYSTEM_PK" ON "MANAGER"."IO" ("TIMESTAMP") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "TP_TABLES" ;
--------------------------------------------------------
--  DDL for Index TABLESPACE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "MANAGER"."TABLESPACE_PK" ON "MANAGER"."TABLESPACE" ("NAME", "TIMESTAMP") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TP_TABLES" ;
--------------------------------------------------------
--  DDL for Index USERS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "MANAGER"."USERS_PK" ON "MANAGER"."USERS" ("USER_ID", "TIMESTAMP") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TP_TABLES" ;
--------------------------------------------------------
--  Constraints for Table DATAFILE
--------------------------------------------------------

  ALTER TABLE "MANAGER"."DATAFILE" MODIFY ("NAME_DF" NOT NULL ENABLE);
  ALTER TABLE "MANAGER"."DATAFILE" MODIFY ("NAME_TB" NOT NULL ENABLE);
  ALTER TABLE "MANAGER"."DATAFILE" MODIFY ("FILE_SIZE" NOT NULL ENABLE);
  ALTER TABLE "MANAGER"."DATAFILE" MODIFY ("USED_SIZE" NOT NULL ENABLE);
  ALTER TABLE "MANAGER"."DATAFILE" MODIFY ("FREE_SIZE" NOT NULL ENABLE);
  ALTER TABLE "MANAGER"."DATAFILE" MODIFY ("TIMESTAMP" NOT NULL ENABLE);
  ALTER TABLE "MANAGER"."DATAFILE" ADD CONSTRAINT "DATAFILE_PK" PRIMARY KEY ("NAME_DF", "TIMESTAMP")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TP_TABLES"  ENABLE;
--------------------------------------------------------
--  Constraints for Table IO
--------------------------------------------------------

  ALTER TABLE "MANAGER"."IO" MODIFY ("TIMESTAMP" NOT NULL ENABLE);
  ALTER TABLE "MANAGER"."IO" MODIFY ("WRITES" NOT NULL ENABLE);
  ALTER TABLE "MANAGER"."IO" MODIFY ("READS" NOT NULL ENABLE);
  ALTER TABLE "MANAGER"."IO" MODIFY ("FREE_MEMORY" NOT NULL ENABLE);
  ALTER TABLE "MANAGER"."IO" ADD CONSTRAINT "SYSTEM_PK" PRIMARY KEY ("TIMESTAMP")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "TP_TABLES"  ENABLE;
--------------------------------------------------------
--  Constraints for Table SESSIONS
--------------------------------------------------------

  ALTER TABLE "MANAGER"."SESSIONS" MODIFY ("SID" NOT NULL ENABLE);
  ALTER TABLE "MANAGER"."SESSIONS" MODIFY ("USER_ID" NOT NULL ENABLE);
  ALTER TABLE "MANAGER"."SESSIONS" MODIFY ("SERIAL" NOT NULL ENABLE);
  ALTER TABLE "MANAGER"."SESSIONS" MODIFY ("TIMESTAMP" NOT NULL ENABLE);
  ALTER TABLE "MANAGER"."SESSIONS" ADD CONSTRAINT "SESSIONS_PK" PRIMARY KEY ("SID", "TIMESTAMP")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TP_TABLES"  ENABLE;
--------------------------------------------------------
--  Constraints for Table TABLESPACE
--------------------------------------------------------

  ALTER TABLE "MANAGER"."TABLESPACE" MODIFY ("NAME" NOT NULL ENABLE);
  ALTER TABLE "MANAGER"."TABLESPACE" MODIFY ("USED_SIZE" NOT NULL ENABLE);
  ALTER TABLE "MANAGER"."TABLESPACE" MODIFY ("FREE_SIZE" NOT NULL ENABLE);
  ALTER TABLE "MANAGER"."TABLESPACE" MODIFY ("TOTAL_SIZE" NOT NULL ENABLE);
  ALTER TABLE "MANAGER"."TABLESPACE" MODIFY ("TIMESTAMP" NOT NULL ENABLE);
  ALTER TABLE "MANAGER"."TABLESPACE" ADD CONSTRAINT "TABLESPACE_PK" PRIMARY KEY ("NAME", "TIMESTAMP")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TP_TABLES"  ENABLE;
--------------------------------------------------------
--  Constraints for Table USERS
--------------------------------------------------------

  ALTER TABLE "MANAGER"."USERS" MODIFY ("USER_ID" NOT NULL ENABLE);
  ALTER TABLE "MANAGER"."USERS" MODIFY ("USERNAME" NOT NULL ENABLE);
  ALTER TABLE "MANAGER"."USERS" MODIFY ("ACCOUNT_STATUS" NOT NULL ENABLE);
  ALTER TABLE "MANAGER"."USERS" MODIFY ("DEFAULT_TB" NOT NULL ENABLE);
  ALTER TABLE "MANAGER"."USERS" MODIFY ("TEMP_TB" NOT NULL ENABLE);
  ALTER TABLE "MANAGER"."USERS" MODIFY ("CREATED" NOT NULL ENABLE);
  ALTER TABLE "MANAGER"."USERS" MODIFY ("TIMESTAMP" NOT NULL ENABLE);
  ALTER TABLE "MANAGER"."USERS" ADD CONSTRAINT "USERS_PK" PRIMARY KEY ("USER_ID", "TIMESTAMP")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TP_TABLES"  ENABLE;