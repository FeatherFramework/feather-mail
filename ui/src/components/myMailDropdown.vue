<script setup>
import { ref } from "vue";
import icons from './iconComponent.vue';
import viewRecMail from "./viewRecMail.vue";
import { useRecMailStore } from '@/stores/recMail';
import api from "../api";

function mailChosen(message, mailId) {
  recMail.value = 'From Mail Id: ' + mailId + "\n" + message;
  recMailId.value = mailId;
  showMail.value = true;
  console.log('Mail Id: ' + recMailId.value + ' Mail Message: ' + recMail.value + ' Showing Variable: ' + showMail.value)
}

function mailDeleted() {
  api
  .post('deleteMail', {
    mail_id: recMailId.value
  })
  recMail.value = '';
  recMailId.value = 0;
  showMail.value = false;
}

const showDropdown = ref(false);
const recMail = ref('');
const recMailId = ref(0);
const showMail = ref(false);

const recMailStore = useRecMailStore();
</script>

<template>
  <div class="inline-flex">
    <div
      class="relative inline-flex cursor-pointer"
      @click="showDropdown = !showDropdown"
    >
      My Mail
      <icons name="dropDownArrow"/>
    </div>
    <ul v-if="showDropdown" class="dropdown justify-between bg-slate-600 px-1">
      <li
        class="flex justify-between bg-slate-600 px-1"
        v-for="recMail in recMailStore.recMail"
        :key="recMail.mail_id"
      >
        <button @click="mailChosen(recMail.mail_message, recMail.mail_id), showDropdown = !showDropdown">Mail Number: {{ recMail.mail_id }}</button>
      </li>
    </ul>
    <div v-if="showMail">
        <viewRecMail :mailId="recMailId" :message="recMail" @deleteMail="mailDeleted()"/>
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