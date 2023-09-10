<script setup>
import { ref } from "vue";
import api from '../api';
import icons from './iconComponent.vue';
defineProps({
  accounts: Array
})

const emit = defineEmits([
  'accountCreated'
])

function accountCreated() {
    emit('accountCreated');
    api
    .post('createAccount', {
        type: accountType.value
    })
}

const showAccountTypeDropdown = ref(false);
const accountType = ref(null);
</script>

<template>
    <div class="typeContainer absolute bg-slate-700	">
        <div class="inline-flex">
            <div
              class="relative inline-flex cursor-pointer"
              @click="showAccountTypeDropdown = !showAccountTypeDropdown"
            >
              Choose Account Type
              <icons name="dropDownArrow"/>
            </div>
            <ul v-if="showAccountTypeDropdown" class="accountTypeDropdown justify-between bg-slate-600 px-1">
              <li @click="accountType = 'personal', showAccountTypeDropdown = !showAccountTypeDropdown">
                Personal
              </li>
              <li @click="accountType = 'business', showAccountTypeDropdown = !showAccountTypeDropdown">
                Business
              </li>
            </ul>
        </div>
        <button class="absolute bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded-full -top-2 left-51" @click="accountCreated">
            Confirm
        </button>
    </div>
</template>

<style scoped>
.typeContainer {
    top: 30.0rem;
}
.accountTypeDropdown {
    position: absolute;
    width: 10rem;
    top: 1.5rem;
}
</style>