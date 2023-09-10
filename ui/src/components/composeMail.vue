<script setup>
import { ref } from 'vue';
import api from "../api";

const props = defineProps({
    mailId: Number
})

const emit = defineEmits([
    'mailSent'
])

const mailToSend = ref(null);
function sendMail() {
    api
    .post('sendMail', {
        id_sent_to: props.mailId,
        mail_message: mailToSend.value
    })
    emit('mailSent')
}
</script>

<template>
    <div class="textBox absolute top-80 mb-3 outline outline-2 outline-zinc-950">
        <label
          for="exampleFormControlTextarea1"
          class="hidden"
          > Insert Message
        </label>
        <textarea
          v-model="mailToSend"
          class="resize-none peer block min-h-[auto] w-full rounded border-0 bg-transparent px-3 py-[0.32rem] outline-none text-black placeholder:text-gray-600"
          id="exampleFormControlTextarea1"
          rows="10"
          cols="45"
          placeholder="Your message"/>
        <button
            type="button"
            class="absolute inline-block rounded bg-primary px-6 pb-2 pt-2.5 text-xs font-medium uppercase leading-normal text-black bg-gray-600 hover:opacity-80 my-2 left-28" @click="sendMail()">
            Send Mail
        </button>
      </div>
</template>

<style scoped>
.textBox {
    left: 10rem;
}
</style>