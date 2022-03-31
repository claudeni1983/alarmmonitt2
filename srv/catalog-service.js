const updateSLA = require('./actions/updateSLA')
const getRelatorioSintetic = require('./functions/getRelatorioSintetic')


module.exports = (srv) => {
    // FUNCTIONS    
    srv.on('getRelatorioSintetic', getRelatorioSintetic(srv))
   
    srv.on('updateSLA', updateSLA(srv))
}