<script setup>
import { ref } from 'vue';
import api from '../api';
import { useAccountInfoStore } from '@/stores/accountInfo';
const accountInfoStore = useAccountInfoStore();

const Id = ref(null);

const emit = defineEmits([
  'newAllowedId'
])

function idAdded() {
  accountInfoStore.addAllowedId(Id.value);
  api
  .post('addAllowedId', {
    mail_id: accountInfoStore.accountId,
    allowedId: Id.value
  })
  Id.value = null;
  emit('newAllowedId');
}
</script>

<template>
    <div class="container absolute">
        <form class="w-full max-w-sm">
            <div class="md:flex md:items-center mb-6">
              <div class="md:w-1/3">
                <label class="block text-gray-500 font-bold md:text-right mb-1 md:mb-0 pr-4">
                    New Id:
                </label>
              </div>
              <div class="md:w-2/3">
                <input v-model="Id" class="bg-gray-200 appearance-none border-2 border-gray-200 rounded w-full py-2 px-4 text-gray-700 leading-tight focus:outline-none focus:bg-white focus:border-purple-500" type="number" placeholder="Mail Id">
              </div>
            </div>
            <div class="md:flex md:items-center">
              <div class="md:w-1/3"></div>
              <div class="md:w-2/3">
                <button class="shadow bg-purple-500 hover:bg-purple-400 focus:shadow-outline focus:outline-none text-white font-bold py-2 px-4 rounded" type="button" @click="idAdded">
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
}
</style>