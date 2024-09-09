-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "DIM_Well" (
    "Well_ID" int   NOT NULL,
    "Well_Name" string   NOT NULL,
    "Current_Purpose" string   NOT NULL,
    "Current_Status" string   NULL,
    "WellPad_Name" string   NOT NULL,
    CONSTRAINT "pk_DIM_Well" PRIMARY KEY (
        "Well_ID"
     )
);

CREATE TABLE "DIM_Reservoir" (
    "Reservoir_ID" int   NOT NULL,
    "Reservoir_Name" string   NOT NULL,
    "Reservoir_Group" string   NOT NULL,
    "Reservoir_UR_coeff" string   NOT NULL,
    "Production_Start" date   NOT NULL,
    CONSTRAINT "pk_DIM_Reservoir" PRIMARY KEY (
        "Reservoir_ID"
     )
);

CREATE TABLE "DIM_WellEvent" (
    "WellEvent_ID" int   NOT NULL,
    "Well_Event_Code" string   NOT NULL,
    "Well_Event_Date" date   NOT NULL,
    "Well_Event_Group" string   NOT NULL,
    "Well_Event_Type" string   NOT NULL,
    "Well_Type_After_Event" string   NOT NULL,
    CONSTRAINT "pk_DIM_WellEvent" PRIMARY KEY (
        "WellEvent_ID"
     )
);

CREATE TABLE "DIM_Stimulation" (
    "Stimulation_ID" int   NOT NULL,
    "Stimulation_Date" date   NOT NULL,
    "Stimulation_Status" string   NOT NULL,
    CONSTRAINT "pk_DIM_Stimulation" PRIMARY KEY (
        "Stimulation_ID"
     )
);

CREATE TABLE "DIM_ReservoirProperties" (
    "ReservoirProperties_ID" int   NOT NULL,
    "Sublayer_Top_TVDSS" double   NOT NULL,
    "Sublayer_Bottom_TVDSS" double   NOT NULL,
    "Sublayer_Kh" double   NOT NULL,
    CONSTRAINT "pk_DIM_ReservoirProperties" PRIMARY KEY (
        "ReservoirProperties_ID"
     )
);

CREATE TABLE "DIM_Date" (
    "Date_ID" int   NOT NULL,
    "Date_Day" date   NOT NULL,
    "Prior_Date_Day" date   NOT NULL,
    "Next_Date_Day" date   NOT NULL,
    "Prior_Year_Date_Day" date   NOT NULL,
    "Prior_Year_Over_Year_Date_Day" date   NOT NULL,
    "Day_Of_Week" int   NOT NULL,
    "Day_Of_Week_Name" string   NOT NULL,
    "Day_Of_Month" int   NOT NULL,
    "Day_Of_Year" int   NOT NULL,
    CONSTRAINT "pk_DIM_Date" PRIMARY KEY (
        "Date_ID"
     )
);

CREATE TABLE "FACT_WellProduction" (
    "WellProduction_ID" int   NOT NULL,
    "Well_ID" int   NOT NULL,
    "Date_ID" int   NOT NULL,
    "Reservoir_ID" int   NOT NULL,
    "WellEvent_ID" int   NOT NULL,
    "Stimulation_ID" int   NOT NULL,
    "ReservoirProperties_ID" int   NOT NULL,
    "Production_Period" date   NOT NULL,
    "End_Month_Status" string   NOT NULL,
    "Prod_Oil_t" float   NOT NULL,
    "Prod_Water_t" float   NOT NULL,
    "Prod_Gas_k_m3" float   NOT NULL,
    "Work_Hours" float   NOT NULL,
    "Accum_Hours" float   NOT NULL,
    "Standby_Hours" float   NOT NULL,
    CONSTRAINT "pk_FACT_WellProduction" PRIMARY KEY (
        "WellProduction_ID"
     )
);

ALTER TABLE "FACT_WellProduction" ADD CONSTRAINT "fk_FACT_WellProduction_Well_ID" FOREIGN KEY("Well_ID")
REFERENCES "DIM_Well" ("Well_ID");

ALTER TABLE "FACT_WellProduction" ADD CONSTRAINT "fk_FACT_WellProduction_Date_ID" FOREIGN KEY("Date_ID")
REFERENCES "DIM_Date" ("Date_ID");

ALTER TABLE "FACT_WellProduction" ADD CONSTRAINT "fk_FACT_WellProduction_Reservoir_ID" FOREIGN KEY("Reservoir_ID")
REFERENCES "DIM_Reservoir" ("Reservoir_ID");

ALTER TABLE "FACT_WellProduction" ADD CONSTRAINT "fk_FACT_WellProduction_WellEvent_ID" FOREIGN KEY("WellEvent_ID")
REFERENCES "DIM_WellEvent" ("WellEvent_ID");

ALTER TABLE "FACT_WellProduction" ADD CONSTRAINT "fk_FACT_WellProduction_Stimulation_ID" FOREIGN KEY("Stimulation_ID")
REFERENCES "DIM_Stimulation" ("Stimulation_ID");

ALTER TABLE "FACT_WellProduction" ADD CONSTRAINT "fk_FACT_WellProduction_ReservoirProperties_ID" FOREIGN KEY("ReservoirProperties_ID")
REFERENCES "DIM_ReservoirProperties" ("ReservoirProperties_ID");

CREATE INDEX "idx_DIM_Well_Well_Name"
ON "DIM_Well" ("Well_Name");

