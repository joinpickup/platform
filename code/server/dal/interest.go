package dal

import (
	"auth-service/model"
	"database/sql"
)

func GetAllIntersts(db *sql.DB) ([]model.Interest, error) {
	interests := []model.Interest{}
	rows, err := db.Query("SELECT * from get_all_interests()")

	if err != nil {
		return nil, err
	}

	for rows.Next() {
		var interest model.Interest

		err := rows.Scan(
			&interest.InterestID,
			&interest.Name,
			&interest.Space.Name,
			&interest.Space.SpaceID,
			&interest.CreatedAt,
		)

		if err != nil {
			return nil, err
		}

		interests = append(interests, interest)
	}

	return interests, nil
}
