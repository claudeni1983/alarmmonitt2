const luxon = require('luxon')

const handleDate = (fn) => (dt) => {
    const lux = luxon.DateTime
        .fromJSDate(dt || new Date(), {
            zone: "America/Sao_Paulo"
        })

    return fn(lux)
}

const getHour = handleDate((dt) => dt.toFormat('HH:mm:ss'))

const getDate = handleDate((dt) => dt.toFormat('yyyy-MM-dd'))

module.exports = (srv) => async (req) => {
    const { payload: data } = req.data    
    const db = srv.tx(req)
    const {
        AM_SLA
    } = srv.entities

    const [ AM_SLA_DB ] = await db
        .read(AM_SLA)
        .where({ numero_ov: data.numero_ov })
        .orderBy(c => c.get("data_sla").desc(), c => c.get("hra_sla").desc());

    console.log(getDate())
    console.log(getHour())

    if (!AM_SLA_DB || AM_SLA_DB.status !== data.status) {
        return await db
            .create(AM_SLA, data)
    }

    return await db
        .update(AM_SLA)
        .where({ numero_ov: AM_SLA_DB.numero_ov })
        .with({
            data_encerramento: getDate(),
            hra_encerramento: getHour(),
        })
}