const luxon = require('luxon')

const handleDate = (dt,range) => {
    const lux = luxon.DateTime
        .fromJSDate(dt, {
            zone: "America/Sao_Paulo"
        })
        .plus({ minutes: range })

    return lux
}
const getToRangeDate = (oData,range,typeTime)=>{
    switch(typeTime){
        case 'hour':
            return handleDate(oData, range).toFormat('HH:mm:ss')
        case 'date':
            return handleDate(oData, range).toFormat('yyyy-MM-dd')
    }
}
const getHourFromODate = (sDate,range)=>{
    const oDate = new Date(sDate.getTime() + range*60000);
    const hour = oDate.getHours();
    const minutes = oDate.getMinutes();
    const seconds = oDate.getSeconds();
return `${validLeftZero(hour)}:${validLeftZero(minutes)}:${validLeftZero(seconds)}`
}

const getHour = handleDate((dt) => dt.toFormat('HH:mm:ss'))
const getDateNow = handleDate((dt) => dt)
const getDateFromODate = (sDate)=>{
    const oDate = new Date(sDate);
    const day = oDate.getDate();
    const month = oDate.getMonth()+1;
    const year = oDate.getFullYear();
return `${year}-${validLeftZero(month)}-${validLeftZero(day)}`
}
var add_minutes =  function (dt, minutes) {
    return new Date(dt.getTime() + minutes*60000);
}

const validLeftZero=(number)=>(number<10?`0${number}`:number);
module.exports = {    
    getToRangeDate,
    getHourFromODate
}