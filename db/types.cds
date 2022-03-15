namespace alarmmonitt2_types;

type rtnServiceAttSLA {
    action:String   
}

type AttSLAType {
    sequencial          : String(32) not null;
    numero_ov           : Integer not null;
    dt_st_atual         : Date not null;
    hr_st_atual         : Time not null;
    tipo_ov             : String(50);
    status              : String;
    org_vendas          : String(4);
    cnl_distr           : String(2);
    escr_vdas           : String(4);
    eqp_vdas            : String(50);
    data_sla            : Date;
    hra_sla             : Time;
    nivel               : Integer;
    usuario             : String(50);
    btp                 : Boolean;
    expresso            : Boolean;
    dta_slalocal        : Date;
    hra_slalocal        : Time;
    email               : String(500);
    data_encerramento   : Date;
    hra_encerramento : Time;
}