import axios from "axios";

const api = axios.create({
	baseURL: `https://${typeof GetParentResourceName !== 'undefined' ? GetParentResourceName() : 'bcc-mail'}/`,
});

export default api;
