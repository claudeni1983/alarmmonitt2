using {alarmmonitt2.db.ALARMMONIT as ALARMMONIT} from '../db/schema';
using alarmmonitt2_types as types from '../db/types';
service CatalogService @(path : '/srv') {

 

    entity AM_EMAILXFONENUMBER as projection on ALARMMONIT.AM_EMAILXFONENUMBER;
    entity AM_JOB              as projection on ALARMMONIT.AM_JOB;
    entity AM_SLA              as projection on ALARMMONIT.AM_SLA;
    entity AM_SLA_LEGADO       as projection on ALARMMONIT.AM_SLA_LEGADO;
    entity AM_STATUS           as projection on ALARMMONIT.AM_STATUS;
    entity AM_STATUSTXT        as projection on ALARMMONIT.AM_STATUSTXT;
    entity AM_VENDAS           as projection on ALARMMONIT.AM_VENDAS;
    entity relatorioSint       as projection on ALARMMONIT.retalorioSint;
    entity retatorioAnalitico  as projection on ALARMMONIT.retalorioAnalitico;
    entity analyticalReport       as projection on ALARMMONIT.analyticalReport;
    entity syntheticalReport       as projection on ALARMMONIT.syntheticalReport;
    entity relSintetico_Nivel       as projection on ALARMMONIT.relSintetico_Nivel;
    function getRelatorioSintetic (![from]: String, ![range]: Integer) returns types.rtnServiceGetRelatorioSintetic;
    action updateSLA(payload: types.AttSLAType) returns types.rtnServiceAttSLA;
};
