module.exports = (srv) => async (req) => {
    const { payload: userData } = req.data    
    const db = srv.tx(req)
    const {
        AM_SLA
    } = srv.entities

    const [ AM_SLA_DB ] = await db.read(AM_SLA).where({ numero_ov: userData.ov })
    .orderBy(c => c.get("data_sla").desc(), c => c.get("hra_sla").desc());
    if (!AM_SLA_DB) {
        return req.reject(404, `ov '${userData.ov}' not found.`)
    }    
    if(AM_SLA_DB.status !== userData.status){        
        return await db
        .update(AM_SLA)
        .where({ numero_ov: AM_SLA_DB.ov })
        .with({ data_sla: userData.data_sla ,hra_sla: userData.hra_sla})
    }
    console.log(AM_SLA_DB)
    return {...AM_SLA_DB}
}