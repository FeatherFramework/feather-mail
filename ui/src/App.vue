<script setup>
import api from "./api";
import { ref, onMounted, onUnmounted } from "vue";
import contactDropdown from "./components/contactDropdown.vue";
import myMailDropdown from './components/myMailDropdown.vue';
import allowedIdDropdown from "./components/allowedIdDropdown.vue";
import { useContactListStore } from "./stores/contacts";
import { useRecMailStore } from "./stores/recMail";
import { useAccountInfoStore } from "./stores/accountInfo";
import accountSelection from "./components/accountSelection.vue";
import "@/assets/styles/main.css";

const devmode = ref(false);
const visible = ref(false);

onMounted(() => {
  window.addEventListener("message", onMessage);
});

onUnmounted(() => {
  window.removeEventListener("message", onMessage);
});

const accountList = ref(null);
const contactStore = useContactListStore();
const recMailStore = useRecMailStore();
const accountInfoStore = useAccountInfoStore();
const selectedAccount = ref(null);
const isOwner = ref(false);
const isBusinessAccount = ref(false);
const onMessage = (event) => {
  switch (event.data.type) {
    case "toggle":
      visible.value = event.data.visible;
      accountList.value = event.data.accounts;
      api
        .post("updatestate", {
          state: visible.value,
        })
        .catch((e) => {
          console.log(e.message);
        });
      break;
    case 'recieveSelectedAccountInfo':
      selectedAccount.value = event.data.account;
      accountInfoStore.setAccountInfo(event.data.accountInfo, event.data.accountInfo.mail_id, event.data.isOwner, event.data.allowedIds);
      isOwner.value = event.data.isOwner;
      if (event.data.accountType == 'business') {
        isBusinessAccount.value = true;
      }
      contactStore.storeContacts(event.data.contacts);
      recMailStore.setRecMail(event.data.recMail);
      showAccountSelection.value = false;
      accountChosen.value = true;
      break;
    default:
      break;
  }
};

const closeApp = () => {
  visible.value = false;
  api
    .post("updatestate", {
      state: visible.value,
    })
    .catch((e) => {
      console.log(e.message);
    });
};

const accountChosen = ref(false);
const showAccountSelection = ref(true);
function accountSelected(mailId, isOwner) {
  selectedAccount.value = mailId;
  accountChosen.value = true;
  showAccountSelection.value = false;
  api
  .post('getSelectedAccountInfo', {
    account: selectedAccount.value,
    isOwner: isOwner
  })
  .catch((e) => {
      console.log(e.message);
    });
}
</script>

<template>
  <div
    id="container"
    class="relative bg-gray-900 left-0 right-0 mx-auto"
    v-if="visible || devmode"
  >
    <div class="closeApp absolute right-2 -top-2 text-2xl text-white" @click="closeApp">
      &times;
    </div>
    <accountSelection v-if="showAccountSelection" :accounts="accountList" @accountSelected="accountSelected" @createAccount="closeApp"/>
    <nav v-if="accountChosen && (accountType = 'business')" class="w-full text-center text-white bg-slate-800">
      <myMailDropdown class="mr-10"/> |
      <contactDropdown class="ml-10"/>
      <div v-if="isOwner && isBusinessAccount" class="absolute -top-0">
        <allowedIdDropdown/>
      </div>
    </nav>
    <!-- <router-view /> -->
  </div>
</template>

<style scoped>
#container {
  width: 60vw;
  height: 70vh;
  background-image: url('./assets/imgs/postcard.png');
  background-repeat: no-repeat;
  background-size: cover;
}
.closeApp:hover{
  opacity: 90%;
  cursor: pointer;
}
</style>