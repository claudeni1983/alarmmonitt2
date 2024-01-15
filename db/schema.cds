namespace alarmmonitt2.db;

context ALARMMONIT {
    @cds.persistence.exists
    entity AM_EMAILXFONENUMBER {
        key email      : String(100) not null;
            fonenumber : Integer;
    };

    @cds.persistence.exists
    entity AM_JOB {
        key sequencial : String(32) not null;
            hora       : Time;
            email      : String(100);
    };

    @cds.persistence.exists
    entity AM_SLA {
        key numero_ov         : Integer not null;
        key sequencial        : String(32) not null;
            dt_st_atual       : Date not null;
            hr_st_atual       : Time not null;
            tipo_ov           : String(50);
            status            : String;
            org_vendas        : String(4);
            cnl_distr         : String(2);
            escr_vdas         : String(4);
            eqp_vdas          : String(50);
            data_sla          : Date;
            hra_sla           : Time;
            nivel             : Integer;
            usuario           : String(50);
            btp               : Boolean;
            expresso          : Boolean;
            dta_slalocal      : Date;
            hra_slalocal      : Time;
            email             : String(500);
            data_encerramento : Date;
            hra_encerramento  : Time;
            systemid          : String(50);
            celular           : String(500);
            encerrado         : Boolean;
    };

    @cds.persistence.exists
    entity AM_SLA_LEGADO {
        key numero_ov   : Integer not null;
    };

    @cds.persistence.exists
    entity AM_STATUS { 
        key id_sistema        : String(50) not null;
        key id_organizacional : String(50) not null;
        key status            : String(50) not null;
        key expresso          : Boolean not null;
        key nivel             : Integer not null;
            email             : String(500);
            celular           : String(500);
    };

    @cds.persistence.exists
    entity AM_STATUSTXT {
        key systemid  : String(20) not null;
        key status    : String(50) not null;
            descricao : String(100);
    };

    @cds.persistence.exists
    entity AM_VENDAS {
        key tipo_documento_vendas : String(50) not null;
        key canal_distribuicao    : Integer not null;
        key nivel                 : Integer not null;
        key status                : Integer not null;
        key expresso              : Boolean not null;
            sla                   : String(8);
            hrs_uteis             : Boolean;
    };

    entity retalorioSint      as
        select
            AM_STATUSTXT.systemid          as sistema,
            AM_SLA.numero_ov               as ordemVenda,
            AM_SLA.status,
            AM_STATUSTXT.descricao         as descrStatus,
            AM_SLA.data_sla                as dt_stat_atual,
            AM_SLA.hra_sla                 as hr_stat_atual,
            AM_EMAILXFONENUMBER.email,
            AM_EMAILXFONENUMBER.fonenumber as fone,
            AM_SLA.data_encerramento       as DT_ENCERRAMENTO,
            AM_SLA.hra_encerramento
        from ALARMMONIT.AM_SLA as AM_SLA
        left join ALARMMONIT.AM_STATUSTXT as AM_STATUSTXT
            on AM_SLA.status = AM_STATUSTXT.status
        left join ALARMMONIT.AM_EMAILXFONENUMBER as AM_EMAILXFONENUMBER
            on AM_SLA.email = AM_EMAILXFONENUMBER.email;

    entity retalorioAnalitico as
        select
            AM_STATUS.id_sistema     as id_sistema,
            AM_STATUS.nivel          as nivel,
            AM_STATUS.status         as status,
            AM_STATUS.email          as email,
            EMAILXFONE.fonenumber    as celular,
            AM_SLA.numero_ov         as ov, 
            AM_SLA.data_sla          as data_sla,
            AM_SLA.hra_sla           as hra_sla,
            AM_SLA.dt_st_atual       as dt_st_atual,
            AM_SLA.hr_st_atual       as hr_st_atual,
            AM_SLA.data_encerramento as data_encerramento,
            AM_SLA.hra_encerramento  as hra_encerramento
        from ALARMMONIT.AM_SLA as AM_SLA
        inner join ALARMMONIT.AM_STATUS as AM_STATUS
            on AM_SLA.status = AM_STATUS.status
        inner join ALARMMONIT.AM_EMAILXFONENUMBER as EMAILXFONE
            on EMAILXFONE.email = AM_SLA.email;


    entity retatorioSintetico as
        select
            AM_STATUS.id_sistema           as id_sistema,
            AM_STATUS.id_sistema           as ordemVenda,
            AM_STATUS.status               as status,
            AM_STATUS.nivel                as nivel,
            AM_STATUS.email                as email,
            AM_SLA.data_sla                as hr_stat_atual,
            AM_EMAILXFONENUMBER.fonenumber as fone,
            AM_SLA.data_encerramento       as DT_ENCERRAMENTO,
            AM_SLA.hra_encerramento
        from ALARMMONIT.AM_SLA as AM_SLA
        left join ALARMMONIT.AM_STATUS as AM_STATUS
            on AM_SLA.status = AM_STATUS.status
        left join ALARMMONIT.AM_EMAILXFONENUMBER as AM_EMAILXFONENUMBER
            on AM_SLA.email = AM_EMAILXFONENUMBER.email;

    entity relSintetico_Nivel as
        select distinct
            SLA.numero_ov         as Numero_OV,
            SLA.status            as Status,
            STATUS.id_sistema     as Sistema,
            NIVEL1.NIVEL          as NIVEL_1,
            NIVEL1.DATA_SLA       as DATA_SLA_1,
            NIVEL1.EMAIL          as EMAIL_1,
            NIVEL1.FONENUMBER     as celular_1,
            NIVEL2.NIVEL          as NIVEL_2,
            NIVEL2.DATA_SLA       as DATA_SLA_2,
            NIVEL2.EMAIL          as EMAIL_2,
            NIVEL2.FONENUMBER     as celular_2,
            NIVEL3.NIVEL          as NIVEL_3,
            NIVEL3.DATA_SLA       as DATA_SLA_3,
            NIVEL3.EMAIL          as EMAIL_3,
            NIVEL3.FONENUMBER     as celular_3,
            STATUSTXT.descricao   as DESCRICAO,
            SLA.data_encerramento as Data_Encerramento
        from ALARMMONIT.AM_SLA as SLA
        inner join (
            select
                SLA1.nivel      as NIVEL,
                SLA1.data_sla   as DATA_SLA,
                SLA1.email      as EMAIL,
                SLA1.numero_ov  as NUMERO_OV,
                FONE.fonenumber as FONENUMBER
            from ALARMMONIT.AM_SLA as SLA1
            inner join ALARMMONIT.AM_EMAILXFONENUMBER as FONE
                on FONE.email = SLA1.email
        ) as NIVEL1
            on  SLA.numero_ov = NIVEL1.NUMERO_OV
            and NIVEL1.NIVEL  = 1
        inner join (
            select
                SLA2.nivel      as NIVEL,
                SLA2.data_sla   as DATA_SLA,
                SLA2.email      as EMAIL,
                SLA2.numero_ov  as NUMERO_OV,
                FONE.fonenumber as FONENUMBER
            from ALARMMONIT.AM_SLA as SLA2
            inner join ALARMMONIT.AM_EMAILXFONENUMBER as FONE
                on FONE.email = SLA2.email
        ) as NIVEL2
            on  SLA.numero_ov = NIVEL2.NUMERO_OV
            and NIVEL2.NIVEL  = 2
        inner join (
            select
                SLA3.nivel      as NIVEL,
                SLA3.data_sla   as DATA_SLA,
                SLA3.email      as EMAIL,
                SLA3.numero_ov  as NUMERO_OV,
                FONE.fonenumber as FONENUMBER
            from ALARMMONIT.AM_SLA as SLA3
            inner join ALARMMONIT.AM_EMAILXFONENUMBER as FONE
                on FONE.email = SLA3.email
        ) as NIVEL3
            on  SLA.numero_ov = NIVEL3.NUMERO_OV
            and NIVEL3.NIVEL  = 3
        inner join ALARMMONIT.AM_STATUS as STATUS
            on STATUS.nivel = SLA.nivel
        left join ALARMMONIT.AM_STATUSTXT as STATUSTXT
            on STATUSTXT.status = STATUS.status;

    entity analyticalReport   as
        select 
            AM_SLA.systemid          as sistema,
            AM_SLA.numero_ov         as ordemVenda,
            AM_SLA.nivel             as nivel,
            AM_SLA.status            as status,
            AM_STATUSTXT.descricao   as descricaoStatus,
            AM_SLA.dt_st_atual       as dataStatus,
            AM_SLA.hr_st_atual       as horaStatus,
            AM_SLA.data_sla          as dataSla,
            AM_SLA.hra_sla           as horaSla,
            AM_SLA.email             as email,
            AM_SLA.celular           as sms,
            AM_SLA.data_encerramento as dataEncerramento,
            AM_SLA.hra_encerramento  as horaEncerramento,
            AM_SLA.encerrado         as encerrado
        from ALARMMONIT.AM_SLA as AM_SLA
        left join ALARMMONIT.AM_STATUSTXT as AM_STATUSTXT
            on AM_SLA.status = AM_STATUSTXT.status
		        ORDER BY AM_SLA.encerrado asc,
                         AM_SLA.dt_st_atual desc, 
		                 AM_SLA.hr_st_atual desc, 
		                 AM_SLA.numero_ov asc,
		                 AM_SLA.status asc,
		                 AM_SLA.nivel asc;

    define view syntheticalReport as 
        select nivel1.systemid as sistema,
            TO_INT(COUNT(nivel1.numero_ov)) AS ordemVenda : Integer,
            nivel1.status as status, 
            STATUSTXT.descricao AS descricaoStatus,
            nivel1.nivel as nivel,
            nivel1.expresso as expresso,
            nivel1.data_sla AS dataSlaNivel1,
            nivel1.email AS emailNivel1,
            nivel1.celular AS celularNivel1,
            nivel2.data_sla AS dataSlaNivel2,
            nivel2.email AS emailNivel2,
            nivel2.celular AS celularNivel2,
            nivel3.data_sla AS dataSlaNivel3,
            nivel3.email AS emailNivel3,
            nivel3.celular AS celularNivel3,
            nivel1.encerrado as encerrado,
            IFNULL(TO_DATE(nivel1.data_encerramento),'0000-00-00') AS dataEncerramento  : Date
                from ALARMMONIT.AM_SLA as nivel1
                    inner join ALARMMONIT.AM_STATUSTXT as STATUSTXT
                        on nivel1.systemid = STATUSTXT.systemid and
                           nivel1.status   = STATUSTXT.status
                    left outer join
                        ( select systemid, numero_ov, dt_st_atual, hr_st_atual,
                                status, nivel, expresso, data_sla, email, celular
                                    from ALARMMONIT.AM_SLA ) as nivel2
                                        on nivel2.numero_ov    = nivel1.numero_ov
                                        and nivel2.status      = nivel1.status
                                        and nivel2.dt_st_atual = nivel1.dt_st_atual
                                        and nivel2.hr_st_atual = nivel1.hr_st_atual
                                        and nivel2.nivel = 2
                    left outer join
                        ( select systemid, numero_ov, dt_st_atual, hr_st_atual, 
                                status, nivel, expresso, data_sla, email, celular
                                    from ALARMMONIT.AM_SLA ) as nivel3
                                        on nivel3.numero_ov    = nivel1.numero_ov
                                        and nivel3.status      = nivel1.status
                                        and nivel3.dt_st_atual = nivel1.dt_st_atual
                                        and nivel3.hr_st_atual = nivel1.hr_st_atual
                                        and nivel3.nivel = 3
                                            where nivel1.nivel = 1                                            
                                                group by nivel1.systemid, 
                                                        nivel1.status, 
                                                        STATUSTXT.descricao,
                                                        nivel1.nivel,                                                         
                                                        nivel1.expresso,
                                                        nivel1.data_sla,
                                                        nivel1.email,
                                                        nivel1.celular,
                                                        nivel2.data_sla, 
                                                        nivel2.email,
                                                        nivel2.celular,	       						    		     
                                                        nivel3.data_sla,
                                                        nivel3.email,
                                                        nivel3.celular,
                                                        nivel1.encerrado,
                                                        nivel1.data_encerramento
                                                            order by nivel1.encerrado asc,
	       						    		    			         nivel1.email desc,	
	       						    		    			         nivel1.data_sla desc;
};