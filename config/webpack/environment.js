const { environment } = require('@rails/webpacker')
const typescript = require('./loaders/typescript')
const vue = require('./loaders/vue')
const eslint =  require('./loaders/eslint')

environment.loaders.append('vue', vue)
environment.loaders.append('typescript', typescript)
environment.loaders.append('eslint', eslint)
module.exports = environment
