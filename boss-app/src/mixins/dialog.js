
const data = () => {
    return {
        objDialog: {
            is: false,
            type: 'add',
            data: '',
        },
    };
};

const methods = {
    handleDialogDisplay (options = { type: 'add', data: '', }, key = 'objDialog') {
        if (this.beforeDialogShow) {
            return this.beforeDialogShow().then(() => this[key] = { ...this[key], is: true, ...(options || {}) })
        }
        this[key] = { ...this[key], is: true, ...(options || {}) };
    },
};

export default {
    data,
    methods,
}
