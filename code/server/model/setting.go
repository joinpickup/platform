package model

type Setting struct {
	SettingID   int    `json:"settingID" db:"setting_id"`
	Name        string `json:"name" db:"name"`
	Description int    `json:"description" db:"description"`
}
