<script setup>
import { ref } from "vue";
import icons from './iconComponent.vue';
import accountCreation from "./accountCreation.vue";
defineProps({
  accounts: Array
})

defineEmits([
  'accountSelected',
  'createAccount'
])

const showDropdown = ref(false);
const showCreation = ref(false);
</script>

<template>
  <div class="inline-flex w-full text-center text-white bg-slate-800">
    <div
      class="relative inline-flex cursor-pointer"
      @click="showDropdown = !showDropdown"
    >
      Choose Account To Access
      <icons name="dropDownArrow"/>
    </div>
    <ul v-if="showDropdown" class="dropdown justify-between bg-slate-600 px-1">
      <li
      class="flex justify-between bg-slate-600 px-1"
      @click="showCreation= !showCreation, showDropdown = !showDropdown"
      >
      Create Account
    </li>
      <li
        class="flex justify-between bg-slate-600 px-1"
        v-for="account in accounts"
        :key="account.mail_id"
      >
        <button @click="showDropdown = !showDropdown, $emit('accountSelected', account.mail_id, account.isOwner)">Account Id: {{ account.mail_id }}</button>
      </li>
    </ul>

    <div v-if="showCreation">
      <accountCreation @accountCreated="$emit('createAccount')"/>
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