-- PBC1
alter table orders_order add column registerpiecework boolean;
alter table basic_parameter add column registerpiecework boolean;
update basic_parameter set registerpiecework=true;
alter table productioncounting_productionrecord add column executedOperationCycles integer;

-- Table: orders_order
-- changed: 28.02.2012

UPDATE basic_parameter SET batchnumberuniqueness='02supplier' WHERE batchnumberuniqueness='02manufacturer';
-- end


-- Table: costcalculation_costcalculation
-- changed: 29.02.2012

ALTER TABLE costcalculation_costcalculation ADD COLUMN sourceofmaterialcosts character varying(255);
ALTER TABLE costcalculation_costcalculation ALTER COLUMN sourceofmaterialcosts SET DEFAULT '01currentGlobalDefinitionsInProduct'::character varying;

ALTER TABLE costcalculation_costcalculation ADD COLUMN printcostnormsofmaterials boolean;
ALTER TABLE costcalculation_costcalculation ALTER COLUMN printcostnormsofmaterials SET DEFAULT true;

ALTER TABLE costcalculation_costcalculation ADD COLUMN printoperationnorms boolean;
ALTER TABLE costcalculation_costcalculation ALTER COLUMN printoperationnorms SET DEFAULT true;

ALTER TABLE costcalculation_costcalculation ADD COLUMN includeadditionaltime boolean;
ALTER TABLE costcalculation_costcalculation ALTER COLUMN includeadditionaltime SET DEFAULT false;

-- end


-- Table: productioncounting_productionbalance
-- changed: 02.03.2012

ALTER TABLE productioncounting_productionbalance ADD COLUMN printoperationnorms boolean;
ALTER TABLE productioncounting_productionbalance ALTER COLUMN printoperationnorms SET DEFAULT true;

ALTER TABLE productioncounting_productionbalance ADD COLUMN calculateoperationcostsmode character varying(255);
ALTER TABLE productioncounting_productionbalance ALTER COLUMN calculateoperationcostsmode SET DEFAULT 'hourly'::character varying;

ALTER TABLE productioncounting_productionbalance ADD COLUMN includetpz boolean;
ALTER TABLE productioncounting_productionbalance ALTER COLUMN includetpz SET DEFAULT true;

ALTER TABLE productioncounting_productionbalance ADD COLUMN includeadditionaltime boolean;
ALTER TABLE productioncounting_productionbalance ALTER COLUMN includeadditionaltime SET DEFAULT false;

ALTER TABLE productioncounting_productionbalance ADD COLUMN sourceofmaterialcosts character varying(255);
ALTER TABLE productioncounting_productionbalance ALTER COLUMN sourceofmaterialcosts SET DEFAULT '01currentGlobalDefinitionsInProduct'::character varying;

ALTER TABLE productioncounting_productionbalance ADD COLUMN calculatematerialcostsmode character varying(255);
ALTER TABLE productioncounting_productionbalance ALTER COLUMN calculatematerialcostsmode SET DEFAULT '01nominal'::character varying;

ALTER TABLE productioncounting_productionbalance ADD COLUMN productioncostmargin numeric(10,3);
ALTER TABLE productioncounting_productionbalance ALTER COLUMN productioncostmargin SET DEFAULT 0::numeric;

ALTER TABLE productioncounting_productionbalance ADD COLUMN materialcostmargin numeric(10,3);
ALTER TABLE productioncounting_productionbalance ALTER COLUMN materialcostmargin SET DEFAULT 0::numeric;

ALTER TABLE productioncounting_productionbalance ADD COLUMN additionaloverhead numeric(10,3);
ALTER TABLE productioncounting_productionbalance ALTER COLUMN additionaloverhead SET DEFAULT 0::numeric;

ALTER TABLE productioncounting_productionbalance ADD COLUMN averagemachinehourlycost numeric(10,3);
ALTER TABLE productioncounting_productionbalance ALTER COLUMN averagemachinehourlycost SET DEFAULT 0::numeric;

ALTER TABLE productioncounting_productionbalance ADD COLUMN averagelaborhourlycost numeric(10,3);
ALTER TABLE productioncounting_productionbalance ALTER COLUMN averagelaborhourlycost SET DEFAULT 0::numeric;
-- end

-- refactoring cost calculation
alter table costcalculation_costcalculation rename column dateofcalculation to date;
alter table costcalculation_costcalculation alter column calculateOperationCostsMode set default '01hourly';
update costcalculation_costcalculation set calculateOperationCostsMode = '01hourly' where calculateOperationCostsMode = 'hourly';
update costcalculation_costcalculation set calculateOperationCostsMode = '02piecework' where calculateOperationCostsMode = 'piecework';