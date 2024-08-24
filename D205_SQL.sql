CREATE TABLE IF NOT EXISTS public.services
(
    customerid text NOT NULL,
    internetservice text,
    phone text,
    multiple text,
    onlinesecurity text,
    onlinebackup text,
    deviceprotection text,
    techsupport text,
    PRIMARY KEY (customerid)
);

CREATE TABLE IF NOT EXISTS public.surveyresponses
(
    customer_id text NOT NULL,
    timelyfixes text,
    timelyreplacements text,
    reliability text,
    options text,
    respectfulresponse text,
    courteousexchange text,
    evidenceofactivelistening text,
    timelyresponse text,
    PRIMARY KEY (customer_id)
);

(Create Table public.joined
as (select * from public.services)
);
(Alter Table public.joined
add column reliability text
 );
 (Update public.joined
 set reliabilty =(select reliability from public.surveyresponse
				 where public.joined.customerid = public.surveyresponses.customer_id)
 );

(Select((count(reliability) filter(where internetservice = 'Fiber Optic' and multiple='Yes')*1.0)
/(count(*)filter(where internetservice ='Fiber Optic')*1.0) *100)
As Fiber_Optic_Reliability,
((count(reliability) filter(where internetservice = 'DSL' and multiple='Yes')*1.0)
/(count(*)filter(where internetservice ='DSL')*1.0) *100)
As DSL_Reliability
From public.joined
 );
