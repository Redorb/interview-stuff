import superagentPromise from 'superagent-promise';
import _superagent from 'superagent';

const superagent = superagentPromise(_superagent, global.Promise);
const API_ROOT = `${window.location.origin}/api`;
const responseBody = res => res.body;

const requests = {
  del: url =>
    superagent.del(`${API_ROOT}${url}`).then(responseBody),
  get: url =>
    superagent.get(`${API_ROOT}${url}`).then(responseBody),
  put: (url, body) =>
    superagent.put(`${API_ROOT}${url}`, body).then(responseBody),
  post: (url, body) =>
    superagent.post(`${API_ROOT}${url}`, body).then(responseBody)
};

const Bookings = {
  create: (pet_owner, booking) =>
    requests.post(`/pet_owners/${pet_owner}/bookings`, { booking }),
  delete: (pet_owner, booking) =>
    requests.del(`/pet_owners/${pet_owner}/bookings/${booking}`),
  all: (pet_owner) =>
    requests.get(`/pet_owners/${pet_owner}/bookings`),
  get: (pet_owner, booking) =>
    requests.get(`/pet_owners/${pet_owner}/bookings/${booking}`)
};

const Sittings = {
  create: (sitter, sitting) =>
    requests.post(`/sitters/${sitter}/sittings`, { sitting }),
  delete: (sitter, sitting) =>
    requests.del(`/sitters/${sitter}/sittings/${sitting}`),
  all: (sitter) =>
    requests.get(`/sitters/${sitter}/sittings`),
  get: (sitter, sitting) =>
    requests.get(`/sitters/${sitter}/sittings/${sitting}`)
};

const Sitters = {
  all: () =>
    requests.get(`/sitters`),
  get: sitter =>
    requests.get(`/sitters/${sitter}`)
};

const PetOwners = {
  all: () =>
    requests.get(`/pet_owners`),
  get: (pet_owner) =>
    requests.get(`/pet_owners/${pet_owner}`)
};

const UserProfiles = {
  get: (user) =>
    requests.get(`/user_profiles/${user}`)
};

const Pets = {
  create: (pet_owner, pet) =>
    requests.post(`/pet_owners/${pet_owner}/pets`, { pet }),
  delete: (pet_owner, pet) =>
    requests.del(`/pet_owners/${pet_owner}/pets/${pet}`),
  all: (pet_owner) =>
    requests.get(`/pet_owners/${pet_owner}/pets`),
  get: (pet_owner, pet) =>
    requests.get(`/pet_owners/${pet_owner}/pets/${pet}`)
};

export default {
  Bookings,
  PetOwners,
  Pets,
  Sitters,
  Sittings,
  UserProfiles
};