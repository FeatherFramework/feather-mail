import { defineStore } from 'pinia';

export const useContactListStore = defineStore('contacts', {
    state: () => ({
        contacts: null
    }),
    getters: {
        // Sending data to a getter
        // The param after return is the data you're sending in
        // accessing a JS array you can use Array#find to return the object
        getContactById: (state) => {
            return (mailId) => state.contacts.find((contact) => contact.contact_mail_id === mailId);
        },
        getContacts: (state) => {
            return state.contacts;
        }
    },
    actions: {
        storeContacts(contacts) {
            this.contacts = contacts
        },
        createContact(contactName, mailId) {
            if (this.contacts == null || undefined ) {
                this.contacts = [{ contact_name: contactName, contact_mail_id: mailId }]
            } else {
                this.contacts.push({ contact_name: contactName, contact_mail_id: mailId })
            }
        },
        deleteContact(mailId) {
            this.contacts = this.contacts.filter((contact) => contact.contact_mail_id !== mailId)
        }
    },
})