# ----------------------------------------------------------------------------------------------- #
#
@doc """
	PersonName

Struct to represent a person's name with first, middle, last names and an optional suffix.

# Fields
- `firstName::String` : person's first name
- `middleName::String` : person's middle name(s)
- `lastName::String` : person's last name
- `suffix::String` : optional suffix (e.g. "Jr.", "III")
"""
struct PersonName
	firstName::String
	middleName::String
	lastName::String
	suffix::String
	PersonName(firstName::String, middleName::String, lastName::String, suffix::String) = new(firstName, middleName, lastName, suffix)
end

PersonName(firstName::String, middleName::String, lastName::String) = PersonName(firstName, middleName, lastName, "")
PersonName(firstName::String, lastName::String) = PersonName(firstName, "", lastName, "")


# ----------------------------------------------------------------------------------------------- #
#
@doc """
	pybtexToPersonName(author) -> PersonName

Converts a Pybtex person object to a `PersonName` object.
"""
function pybtexToPersonName(author)
	firstName = ""
	middleName = ""
	lastName = ""
	suffix = ""

	nFirstNames = length(author.first_names)
	nMiddleNames = length(author.middle_names)
	nLastNames = length(author.last_names)

	if nFirstNames > 0
		for i = 1 : nFirstNames
			firstName *= removeCurlyBracesLimiters(stringPy2Jl(author.first_names[i - 1]))
			if i < nFirstNames
				firstName *= " "
			end
		end
	end

	if nMiddleNames > 0
		for i = 1 : nMiddleNames
			middleName *= removeCurlyBracesLimiters(stringPy2Jl(author.middle_names[i - 1]))
			if i < nMiddleNames
				middleName *= " "
			end
		end
	end

	if nLastNames > 0
		for i = 1 : nLastNames
			lastName *= removeCurlyBracesLimiters(stringPy2Jl(author.last_names[i - 1]))
			if i < nLastNames
				lastName *= " "
			end
		end
	end

	person = PersonName(firstName, middleName, lastName, suffix)

	return person
end

# ----------------------------------------------------------------------------------------------- #
#