module.exports = {
              compilers: {
                solc: {
                  version: '0.8.12',
                  settings: {
                    optimizer: {
                      enabled: false,
                      runs: 200,
                    },
                    evmVersion: null
                  }
                }
              }
            }