<script setup>
defineProps({
    boldText: String,
    infoText: String
})

defineEmits([
    'confirmed'
])
</script>

<template>
    <main class="confirmModel text-gray-900">
          <div class="bg-white rounded-lg md:max-w-md md:mx-auto p-4 fixed inset-x-0 bottom-0 z-50 mb-4 mx-4 md:relative">
            <div class="md:flex items-center">
              <div class="rounded-full border border-gray-300 flex items-center justify-center flex-shrink-0 mx-auto">
                <i class="bx bx-error text-3xl"></i>
              </div>
              <div class="mt-4 md:mt-0 md:ml-6 text-center md:text-left">
                <p class="font-bold">{{ boldText }}</p>
                <p class="text-sm text-gray-700 mt-1">{{ infoText }}</p>
              </div>
            </div>
            <div class="text-center md:text-right mt-4 md:flex md:justify-end">
              <button @click="$emit('confirmed')" class="block w-full md:inline-block md:w-auto px-4 py-3 md:py-2 bg-red-200 text-red-700 rounded-lg font-semibold text-sm md:ml-2 md:order-2">Confirm</button>
              <button class="block w-full md:inline-block md:w-auto px-4 py-3 md:py-2 bg-gray-200 rounded-lg font-semibold text-sm mt-4 md:mt-0 md:order-1">Cancel</button>
            </div>
        </div>
    </main>
</template>

<style scoped>
.confirmModel {
    width: 40vw;
    height: 40vh;
}
</style>