const updateSLA = require('./actions/updateSLA')

module.exports = (srv) => {
    // FUNCTIONS    
    srv.on('updateSLA', updateSLA(srv))
}