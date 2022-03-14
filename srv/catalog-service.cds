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
    action updateSLA(payload: types.AttSLAType) returns types.rtnServiceAttSLA;
};
