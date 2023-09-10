import { defineStore } from 'pinia';

export const useRecMailStore = defineStore('recMail', {
    state: () => ({
        recMail: null
    }),
    getters: {
        // Sending data to a getter
        // The param after return is the data you're sending in
        // accessing a JS array you can use Array#find to return the object
        getMailById: (state) => {
            return (mailId) => state.recMail.find((mail) => mail.mail_id === mailId);
        },
        getMail: (state) => {
            console.log(JSON.stringify(state.recMail))
            return state.recMail;
        }
    },
    actions: {
        deleteMail(mailId) {
            this.recMail = this.recMail.filter((mail) => mail.mail_id !== mailId);
        },
        setRecMail(recMail) {
            this.recMail = recMail;
        }
    },
})