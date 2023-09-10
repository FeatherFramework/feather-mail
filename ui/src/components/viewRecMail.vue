<script setup>
import { useRecMailStore } from '@/stores/recMail';
const props = defineProps({
    mailId: Number,
    message: String
})

const recMailStore = useRecMailStore();

const emit = defineEmits([
    'deleteMail'
])

function deleteMail() {
    recMailStore.deleteMail(props.mailId)
    emit('deleteMail')
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
          readonly
          v-model="mailToSend"
          class="resize-none peer block min-h-[auto] w-full rounded border-0 bg-transparent px-3 py-[0.32rem] outline-none text-black placeholder:text-black"
          id="exampleFormControlTextarea1"
          rows="10"
          cols="45"
          :placeholder="props.message"/>
        <button
            type="button"
            class="absolute inline-block rounded bg-primary px-6 pb-2 pt-2.5 text-xs font-medium uppercase leading-normal text-black bg-gray-600 hover:opacity-80 my-2 left-28" @click="deleteMail()">
            Delete Mail
        </button>
      </div>
</template>

<style scoped>
.textBox {
    left: 10rem;
}
</style>