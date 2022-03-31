const { getToRangeDate,getHourFromODate } = require('../utils')
module.exports = (srv) => async (req) => {        
    const { from, range } = req.data    
    const db = srv.tx(req)
    const {     
        AM_JOB,  
        relatorioSint
    } = srv.entities   
    const fromHour= getHourFromODate(new Date(from),0,'hour')
    const toHour = getHourFromODate(new Date(from),range, 'hour')    
    console.log(fromHour,toHour)
    const  am_jobDB  = await db.read(AM_JOB).where({hora: { between: fromHour, and: toHour}})  
    objReturnCPI.ListaEmails = am_jobDB  
    if(!am_jobDB.length){     
        objReturnCPI.RelatSintetico = [];   
        return objReturnCPI        
    }
    const {dateFrom,hourFrom} = filterCompareDateHour(new Date(),range);    
    
    const  relSintDB  = await db.read(relatorioSint)
    .where({
        DT_ENCERRAMENTO: { '<=': dateFrom }
        ,hra_encerramento: { '<=': hourFrom }
    })
   console.log(relSintDB)
    objReturnCPI.RelatSintetico = relSintDB
    return  objReturnCPI   
}
const filterCompareDateHour = (dateNow)=>({
    dateFrom :getToRangeDate(dateNow,0,'date'),    
    hourFrom :getToRangeDate(dateNow,0,'hour')    
})
const objReturnCPI = {
    "ListaEmails": [],
    "RelatSintetico": []
}