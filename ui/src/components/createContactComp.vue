<script setup>
import { ref } from 'vue';
import { useContactListStore } from '@/stores/contacts';
import api from '../api';

const contactName = ref(null);
const mailId = ref(null);
const contactStore = useContactListStore();
function contactCreated() {
  api
  .post('createContact', {
    contact_name: contactName.value,
    contact_mail_id: mailId.value
  })
  contactStore.createContact(contactName.value, mailId.value)
  contactName.value = null;
  mailId.value = null;
}
</script>

<template>
    <div class="container absolute">
        <form class="w-full max-w-sm">
            <div class="md:flex md:items-center mb-6">
              <div class="md:w-1/3">
                <label class="block text-gray-500 font-bold md:text-right mb-1 md:mb-0 pr-4" for="inline-full-name">
                  Contact Name
                </label>
              </div>
              <div class="md:w-2/3">
                <input v-model="contactName" class="bg-gray-200 appearance-none border-2 border-gray-200 rounded w-full py-2 px-4 text-black leading-tight focus:outline-none focus:bg-white" type="text" placeholder="contactName">
              </div>
            </div>
            <div class="md:flex md:items-center mb-6">
              <div class="md:w-1/3">
                <label class="block text-gray-500 font-bold md:text-right mb-1 md:mb-0 pr-4">
                  Mail Id
                </label>
              </div>
              <div class="md:w-2/3">
                <input v-model="mailId" class="bg-gray-200 appearance-none border-2 border-gray-200 rounded w-full py-2 px-4 text-black leading-tight focus:outline-none focus:bg-white" type="number" placeholder="mailId">
              </div>
            </div>
            <div class="md:flex md:items-center">
              <div class="md:w-1/3"></div>
              <div class="md:w-2/3">
                <button class="shadow bg-gray-500 hover:bg-gray-400 focus:shadow-outline focus:outline-none text-white font-bold py-2 px-4 rounded" type="button" @click="contactCreated()">
                  Create
                </button>
              </div>
            </div>
          </form>
    </div>
</template>

<style scoped>
.container {
    top: 23rem;
    left: 39.8rem;
    width: 20vw;
    font-size: 16.5px;
}
</style>