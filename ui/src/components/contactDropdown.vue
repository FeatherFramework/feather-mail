<script setup>
import { ref } from "vue";
import { storeToRefs } from "pinia";
import contactComp from './contactComp.vue';
import createContactComp from './createContactComp.vue';
import composeMail from './composeMail.vue';
import icons from './iconComponent.vue';
import { useContactListStore } from '@/stores/contacts';
import { useAccountInfoStore } from "@/stores/accountInfo";
import api from '../api';

function contactChosen(name, mailId) {
  contactName.value = name;
  contactmailId.value = mailId;
  showContact.value = true;
}

const accountInfoStore = useAccountInfoStore();
function contactDeleted() {
  api
  .post('contactDeleted', {
    ownerId: accountInfoStore.accountId,
    contactId: contactmailId.value
  })
  contactName.value = '';
  contactmailId.value = 0;
  showComposeMail.value = false;
  showContact.value = false;
}

const showDropdown = ref(false);
const showContactCreation = ref(false);
const contactName = ref('');
const contactmailId = ref(0);
const showContact = ref(false);
const showComposeMail = ref(false);

const contactStore = useContactListStore();
const { getContacts } = storeToRefs(contactStore);
</script>

<template>
  <div class="inline-flex">
    <div
      class="relative inline-flex cursor-pointer"
      @click="showDropdown = !showDropdown"
    >
      Contact List
      <icons name="dropDownArrow"/>
    </div>
    <ul v-if="showDropdown" class="dropdown justify-between bg-slate-600 px-1">
      <li>
        <button @click="showContactCreation = !showContactCreation, showContact = false, showDropdown = !showDropdown, showComposeMail = false">
          Create A Contact
        </button>
      </li>
      <li
        class="flex justify-between bg-slate-600 px-1"
        v-for="contacts in getContacts"
        :key="contacts.contact_mail_id"
      >
        <button @click="contactChosen(contacts.contact_name, contacts.contact_mail_id), showDropdown = !showDropdown, showContactCreation = false, showComposeMail = false">{{ contacts.contact_name }} {{ contacts.contact_mail_id }}</button>
      </li>
    </ul>

    <div v-if="showContact">
      <contactComp :name="contactName" :mailId="contactmailId" @deleteContact="contactDeleted()" @composeMail="showComposeMail = true"/>
    </div>
    
    <div v-if="showContactCreation">
      <createContactComp/>
    </div>

    <div v-if="showComposeMail">
      <composeMail :mailId="contactmailId" @mailSent="showComposeMail = false"/>
    </div>

  </div>
</template>

<style scoped>
.dropdown {
  position: absolute;
  width: 10rem;
  top: 1.5rem;
}
</style>