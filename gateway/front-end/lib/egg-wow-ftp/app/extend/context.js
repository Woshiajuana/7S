'use strict';

module.exports = {
    /**
     * FTP Singleton instance
     * @member Context#oss
     * @since 1.0.0
     * @see App#oss
     */
    get ftp() {
        return this.app.ftp;
    },
};
