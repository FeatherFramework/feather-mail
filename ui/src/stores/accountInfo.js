import { defineStore } from 'pinia';

export const useAccountInfoStore = defineStore('accountInfo', {
    state: () => ({
        accountInfo: null,
        isOwner: null,
        accountId: null,
        allowedIds: []
    }),
    actions: {
        deleteAllowedId(Id) {
            console.log(JSON.stringify(this.allowedIds));
            this.allowedIds = this.allowedIds.filter((allowed) => allowed.id !== Id);
            console.log(JSON.stringify(this.allowedIds));
        },
        addAllowedId(recId) {
            this.allowedIds.push({id:recId});
        },
        setAccountInfo(recInfo, recId, recOwner, recAllowedIds) {
            this.accountInfo = recInfo;
            this.accountId = recId;
            this.isOwner = recOwner;
            this.allowedIds = recAllowedIds;
        }
    },
})