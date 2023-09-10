<script setup>
import { ref } from "vue";
import api from "../api";
import icons from './iconComponent.vue';
import { useAccountInfoStore } from "@/stores/accountInfo";
import addId from './addId.vue';
import confirmationModul from "./confirmationModul.vue";
const accountInfoStore = useAccountInfoStore();
const showDropdown = ref(false);
const showAddId = ref(false);
const showDeleteid = ref(false);
const choseId = ref(null);
const allowedIdList = ref(accountInfoStore.allowedIds);

function allowedIdDeleted() {
  accountInfoStore.deleteAllowedId(choseId.value);
  showDropdown.value = false;
  showDeleteid.value = false;
  allowedIdList.value = accountInfoStore.allowedIds;
  api
  .post('allowedIdDeleted', {
    deletedId: choseId.value,
    mailId: accountInfoStore.accountId
  })
  choseId.value = null;
}
</script>

<template>
  <div class="inline-flex">
    <div
      class="relative inline-flex cursor-pointer"
      @click="showDropdown = !showDropdown"
    >
      Allowed To View
      <icons name="dropDownArrow"/>
    </div>
    <ul v-if="showDropdown" class="dropdown justify-between bg-slate-600 px-1">
      <li>
        <button @click="showAddId = !showAddId, showDropdown = !showDropdown">
          Add an Id
        </button>
      </li>
      <li
        class="flex justify-between bg-slate-600 px-1"
        v-for="id in allowedIdList"
        :key="'allowedIds' + id"
      >
        <button @click="choseId=id.id, showDropdown = !showDropdown, showDeleteid = !showDeleteid">{{ id.id }}</button>
      </li>
    </ul>
  </div>

  <div v-if="showAddId">
    <addId @newAllowedId="showAddId = !showAddId"/>
  </div>

  <div v-if="showDeleteid">
    <confirmationModul @confirmed="allowedIdDeleted" boldText="Delete This Id?"  infoText="Deleting this id will remove them from the list of ids that can access this mail account"/>
  </div>
</template>

<style scoped>
.dropdown {
  position: absolute;
  width: 10rem;
  top: 1.5rem;
}
</style>