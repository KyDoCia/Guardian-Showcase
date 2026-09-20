--!strict

export type Accepted = {
	ok: true,
}

export type Rejected = {
	ok: false,
	code: string,
}

export type ValidationResult = Accepted | Rejected

return {}
