"""Add user profile fields

Revision ID: 4442cf1684dc
Revises: 1805c103f093
Create Date: 2025-11-22 12:06:41.151762

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '4442cf1684dc'
down_revision: Union[str, Sequence[str], None] = '1805c103f093'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    """Upgrade schema."""
    # Add new columns
    op.add_column('users', sa.Column('office', sa.String(), nullable=True))
    op.add_column('users', sa.Column('date_of_birth', sa.Date(), nullable=True))
    op.add_column('users', sa.Column('department', sa.String(), nullable=True))
    op.add_column('users', sa.Column('interests', sa.JSON(), nullable=True))
    op.add_column('users', sa.Column('grade', sa.String(), nullable=True))
    op.add_column('users', sa.Column('company_start_date', sa.Date(), nullable=True))

    # Remove old column
    op.drop_column('users', 'job_title')


def downgrade() -> None:
    """Downgrade schema."""
    # Restore old column
    op.add_column('users', sa.Column('job_title', sa.String(), nullable=True))

    # Remove new columns
    op.drop_column('users', 'company_start_date')
    op.drop_column('users', 'grade')
    op.drop_column('users', 'interests')
    op.drop_column('users', 'department')
    op.drop_column('users', 'date_of_birth')
    op.drop_column('users', 'office')
