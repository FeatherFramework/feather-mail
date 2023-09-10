<script setup>
import icons from './iconComponent.vue';
import { useContactListStore } from '@/stores/contacts';

defineProps({
    name: String,
    mailId: Number
})

const emit = defineEmits([
    'deleteContact',
    'composeMail'
])

const contactStore = useContactListStore();
function deleteContact(mailId) {
    contactStore.deleteContact(mailId);
    emit('deleteContact')
}
</script>

<template>
    <div class="container absolute text-left">
        Name: {{ name }} <br>
        Mail Id: {{ mailId }} <br>
        <div class="flex justify-start w-full gap-3">
            <button class=" text-red-800" @click="deleteContact(mailId)">
                <icons name="trash"/>
            </button>
            <button class=" text-gray-800" @click="$emit('composeMail')"> <!--Emitting without function-->
                <icons name="compose"/>
            </button>
        </div>
    </div>
</template>

<style scoped>
.container {
    top: 23rem;
    left: 39.8rem;
    color: black;
    width: 20vw;
    font-size: 20px;
}
</style>