'use strict';

module.exports = {
    async validateBody(expect, config) {
        return await this.app.validate.check(this.request.body, expect, config);
    },
    async validateQuery(expect, config) {
        return await this.app.validate.check(this.request.query, expect, config);
    },
    async validateFiles(expect, config) {
        return await this.app.validate.check(this.request.files || [], expect, config);
    },
};
